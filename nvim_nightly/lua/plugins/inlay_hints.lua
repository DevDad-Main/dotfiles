-- Inlay hints flicker while typing because the builtin capability (0.12+/nightly)
-- re-requests and re-renders the full hint set on every text change, and
-- rust-analyzer re-computes hints for the transient, incomplete syntax at the
-- cursor. Debounce the refresh-request so hints update once shortly after the
-- user stops typing instead of blinking on/off per keystroke.
local DEBOUNCE_MS = 300

local function patch()
  local ok_cap, cap = pcall(require, "vim.lsp._capability")
  local ok_ih, _ = pcall(require, "vim.lsp.inlay_hint")
  if not ok_cap or not ok_ih then
    return
  end

  local InlayHint = cap.all["inlay_hint"]
  if not InlayHint or InlayHint._debounced then
    return
  end
  InlayHint._debounced = true

  local orig_refresh = InlayHint.refresh
  local timers = {}

  local function reset(key)
    local t = timers[key]
    if t then
      pcall(t.stop, t)
      pcall(t.close, t)
      timers[key] = nil
    end
  end

  function InlayHint:refresh(client_id)
    local key = string.format("%d:%d", self.bufnr, client_id)
    reset(key)
    local bufnr = self.bufnr
    timers[key] = vim.defer_fn(function()
      timers[key] = nil
      local provider = InlayHint.active[bufnr]
      if provider then
        orig_refresh(provider, client_id)
      end
    end, DEBOUNCE_MS)
  end
end

patch()