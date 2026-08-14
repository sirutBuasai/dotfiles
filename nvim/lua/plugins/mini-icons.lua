-- plugins/mini-icons.lua — echasnovski/mini.icons
--
-- Icon provider. Restored your LazyVim-style setup: mini.icons loads lazily and
-- transparently answers `require('nvim-web-devicons')` with its mock (via
-- package.preload), so any plugin expecting devicons gets mini.icons instead.
-- `specs` disables the real nvim-web-devicons if a plugin pulls it in as a dep.
-- (More robust than eagerly mocking at startup.)

return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
