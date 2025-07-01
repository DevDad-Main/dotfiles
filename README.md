# DevDad Dotfiles

<!-- ## About The Project -->

Home repo for all my dotfiles.

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

# Pre-requisites - LazyVim

## ✨ Features

- 🔥 Transform your Neovim into a full-fledged IDE
- 💤 Easily customize and extend your config with lazy.nvim
- 🚀 Blazingly fast
- 🧹 Sane default settings for options, autocmds, and keymaps
- 📦 Comes with a wealth of plugins pre-configured and ready to use

## ⚡️ Requirements

- Neovim >= 0.9.0 (needs to be built with LuaJIT)
- Git >= 2.19.0 (for partial clones support)
- a Nerd Font(v3.0 or greater) (optional, but needed to display some icons)
- lazygit (optional)
- a C compiler for nvim-treesitter. See here
- curl for blink.cmp (completion engine)
- for fzf-lua (optional)
- fzf: fzf (v0.25.1 or greater)
- live grep: ripgrep
- find files: fd
- a terminal that supports true color and undercurl:
  - kitty (Linux & Macos)
  - wezterm (Linux, Macos & Windows)
  - alacritty (Linux, Macos & Windows)
  - iterm2 (Macos)

# Installation

#### 1. Clone the repo:

- Optionally if you are downloading the repo manually just place everything that is inside of the dotfiles directory into the ~./config directory and you can skip the next steps.

  ```bash
  git clone https://github.com/DevDad-Main/dotfiles.git ~/.config/
  ```

#### 2. Create symlinks to the repo:

- Due to how the $XDG_CONFIG_HOME is set, we need to create symlinks

  ```bash
  ln -s ~/.config/dotfiles/nvim ~/.config/nvim
  ln -s ~/.config/dotfiles/tmux ~/.config/tmux
  ln -s ~/.config/dotfiles/yazi ~/.config/yazi
  ```

<!-- 3. Enter your API in `config.js` -->
<!--    ```js -->
<!--    const API_KEY = "ENTER YOUR API"; -->
<!--    ``` -->
<!-- 4. Change git remote url to avoid accidental pushes to base project -->
<!--    ```sh -->
<!--    git remote set-url origin github_username/repo_name -->
<!--    git remote -v # confirm the changes -->
<!--    ``` -->
<!---->
<!-- <!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> --> -->
<!---->
<!-- <!-- USAGE EXAMPLES --> -->
<!---->
<!-- ## Usage -->
<!---->
<!-- Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources. -->
<!---->
<!-- _For more examples, please refer to the [Documentation](https://example.com)_ -->
<!---->
<!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> -->
<!---->
<!-- <!-- ROADMAP --> -->
<!---->
<!-- ## Roadmap -->
<!---->
<!-- - [ ] Feature 1 -->
<!-- - [ ] Feature 2 -->
<!-- - [ ] Feature 3 -->
<!--   - [ ] Nested Feature -->
<!---->
<!-- See the [open issues](https://github.com/github_username/repo_name/issues) for a full list of proposed features (and known issues). -->
<!---->
<!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> -->
<!---->
<!-- <!-- CONTRIBUTING --> -->
<!---->
<!-- ## Contributing -->
<!---->
<!-- Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**. -->
<!---->
<!-- If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement". -->
<!-- Don't forget to give the project a star! Thanks again! -->
<!---->
<!-- 1. Fork the Project -->
<!-- 2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`) -->
<!-- 3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`) -->
<!-- 4. Push to the Branch (`git push origin feature/AmazingFeature`) -->
<!-- 5. Open a Pull Request -->
<!---->
<!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> -->
<!---->
<!-- ### Top contributors: -->
<!---->
<!-- <a href="https://github.com/github_username/repo_name/graphs/contributors"> -->
<!--   <img src="https://contrib.rocks/image?repo=github_username/repo_name" alt="contrib.rocks image" /> -->
<!-- </a> -->
<!---->
<!-- <!-- LICENSE --> -->
<!---->
<!-- ## License -->
<!---->
<!-- Distributed under the project_license. See `LICENSE.txt` for more information. -->
<!---->
<!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> -->
<!---->
<!-- <!-- CONTACT --> -->
<!---->
<!-- ## Contact -->
<!---->
<!-- Your Name - [@twitter_handle](https://twitter.com/twitter_handle) - email@email_client.com -->
<!---->
<!-- Project Link: [https://github.com/github_username/repo_name](https://github.com/github_username/repo_name) -->
<!---->
<!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> -->
<!---->
<!-- <!-- ACKNOWLEDGMENTS --> -->
<!---->
<!-- ## Acknowledgments -->
<!---->
<!-- - []() -->
<!-- - []() -->
<!-- - []() -->
<!---->
<!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> -->
<!---->
<!-- <!-- MARKDOWN LINKS & IMAGES --> -->
<!-- <!-- https://www.markdownguide.org/basic-syntax/#reference-style-links --> -->
<!---->
<!-- [contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge -->
<!-- [contributors-url]: https://github.com/github_username/repo_name/graphs/contributors -->
<!-- [forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge -->
<!-- [forks-url]: https://github.com/github_username/repo_name/network/members -->
<!-- [stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge -->
<!-- [stars-url]: https://github.com/github_username/repo_name/stargazers -->
<!-- [issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge -->
<!-- [issues-url]: https://github.com/github_username/repo_name/issues -->
<!-- [license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge -->
<!-- [license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt -->
<!-- [linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555 -->
<!-- [linkedin-url]: https://linkedin.com/in/linkedin_username -->
<!-- [product-screenshot]: images/screenshot.png -->
<!-- [Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white -->
<!-- [Next-url]: https://nextjs.org/ -->
<!-- [React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB -->
<!-- [React-url]: https://reactjs.org/ -->
<!-- [Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D -->
<!-- [Vue-url]: https://vuejs.org/ -->
<!-- [Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white -->
<!-- [Angular-url]: https://angular.io/ -->
<!-- [Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00 -->
<!-- [Svelte-url]: https://svelte.dev/ -->
<!-- [Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white -->
<!-- [Laravel-url]: https://laravel.com -->
<!-- [Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white -->
<!-- [Bootstrap-url]: https://getbootstrap.com -->
<!-- [JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white -->
<!-- [JQuery-url]: https://jquery.com -->
<!---->
<!-- ``` -->
<!---->
<!-- ``` -->
