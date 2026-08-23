#![doc = include_str!("../README.md")]

use anyhow::anyhow;
use anyhow::ensure;
use anyhow::Result;
use std::borrow::Cow;
use std::env;
use std::process;
use std::process::Command;

struct FileTarget {
    line: Option<u32>,
    column: Option<u32>,
    filename: String,
}

struct Args {
    wait: bool,
    file_targets: Vec<FileTarget>,
}

fn parse_args() -> Result<Args> {
    // True if the subprocess should be forked.
    let mut wait = false;
    // A list of all file targets to open.
    let mut file_targets = Vec::new();
    // True if we are parsing the list of filenames and can no longer accept
    // options.
    let mut at_filename_list = false;
    // Line to open the next file.
    let mut line = None;
    // Column to open the next file.
    let mut column = None;

    // Parse the arguments, building a list of file targets.
    let mut it = env::args().into_iter().skip(1);
    loop {
        let arg = match it.next() {
            Some(arg) => arg,
            None => break,
        };
        if !at_filename_list {
            match arg.as_str() {
                // Ignore these options.
                "nosplash" | "dontReopenProjects" | "disableNonBundledPlugins" => continue,
                "--wait" => {
                    wait = true;
                    continue;
                }
                // These aren't supported and probably never will be.
                "diff" | "merge" | "attach-to-process" => {
                    return Err(anyhow!("Unsupported command: {arg}"))
                }
                _ => at_filename_list = true,
            };
        }
        match arg.as_str() {
            "--line" | "-l" => {
                line = match it.next() {
                    Some(arg) => u32::try_from(arg.parse::<i32>()?).ok(),
                    None => return Err(anyhow!("No integer argument passed to {arg}")),
                };
            }
            "--column" | "-c" => {
                column = match it.next() {
                    // The Emacs command-line treats column 1 as the first column.
                    Some(arg) => u32::try_from(arg.parse::<i32>()?).ok().map(|x| x + 1),
                    None => return Err(anyhow!("No integer argument passed to {arg}")),
                };
            }
            _ => {
                file_targets.push(FileTarget {
                    line,
                    column,
                    filename: arg,
                });
                line = None;
                column = None;
            }
        }
    }

    if file_targets.len() != 1 {
        // If more than one file is passed, remove all sln files.
        file_targets.retain(|x| !x.filename.to_ascii_lowercase().ends_with(".sln"));
    }

    Ok(Args { wait, file_targets })
}

fn try_main() -> Result<()> {
    println!(
        "{}",
        env::args()
            .into_iter()
            .map(|x| format!("“{x}”"))
            .collect::<Vec<_>>()
            .join(" ")
    );
    let options = parse_args()?;

    ensure!(
        !options.file_targets.is_empty(),
        "No file arguments provided"
    );

    let mut args = Vec::new();
    if !options.wait {
        args.push(String::from("-n"));
    }
    for file_target in options.file_targets {
        match file_target.column {
            Some(column) => args.push(format!("+{}:{}", file_target.line.unwrap_or(1), column)),
            None => match file_target.line {
                Some(line) => args.push(format!("+{}", line)),
                None => {}
            },
        }
        args.push(file_target.filename);
    }

    // Spawn process.
    //
    // Always create a new GUI frame with `-c`, then delete any other frames so
    // only one Emacs window is visible at a time. This works around two issues:
    // 1) Unity launches the external editor without a controlling TTY, so
    //    without `-c` emacsclient loads the file into the daemon invisibly.
    // 2) i3 doesn't honor Emacs' `make-frame-visible' request to de-iconify a
    //    frame, so reusing an iconified frame would leave the window hidden.
    //    By always creating a fresh frame and deleting stale ones (including
    //    iconified ones), we guarantee a visible window on every open.
    let escaped_args = args
        .iter()
        .map(|x| shell_escape::unix::escape(Cow::Borrowed(x)))
        .collect::<Vec<_>>()
        .join(" ");
    let status = if cfg!(target_os = "windows") {
        let mut win_args = Vec::from([String::from("-c")]);
        win_args.extend(args);
        Command::new("emacsclientw").args(&win_args).status()
    } else {
        Command::new("sh")
            .arg("-c")
            .arg(format!(
                "emacsclient -c -n {args} && \
                 emacsclient -n -e \
                 '(let ((new (selected-frame))) \
                   (dolist (f (frame-list)) \
                     (unless (eq f new) (ignore-errors (delete-frame f)))) \
                   (select-frame-set-input-focus new))' >/dev/null 2>&1",
                args = escaped_args,
            ))
            .status()
    }?;

    if !status.success() {
        match status.code() {
            Some(code) => return Err(anyhow!("emacsclient error: {code}")),
            None => return Err(anyhow!("emacsclient error")),
        }
    }

    Ok(())
}

fn main() {
    match try_main() {
        Ok(()) => {}
        Err(e) => {
            eprintln!("error: {e}");
            process::exit(1);
        }
    }
}
