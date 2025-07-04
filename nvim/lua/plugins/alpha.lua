local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require("config.icons")

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[                                                                               ]],
  [[                                                                               ]],
  [[                                                                               ]],
  [[                                                                               ]],
  [[                                                                               ]],
  [[                                    ███████                                    ]],
  [[                                ████▒▒▒▒▒▒▒████                                ]],
  [[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
  [[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
  [[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒                              ]],
  [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒▒  ▓▓▓▓                          ]],
  [[                         ██▒▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒▒  ▒▒▓▓                          ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒    ██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
  [[                        ██▒██  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
  [[                        ███     ██      ████      █████                        ]],
  [[                                                                               ]],
  [[                                                                               ]],
  [[         _..._         _..._         _..._         _..._         _..._         ]],
  [[       .:::::::.     .::::. `.     .::::  `.     .::'   `.     .'     `.       ]],
  [[      :::::::::::   :::::::.  :   ::::::    :   :::       :   :         :      ]],
  [[      :::::::::::   ::::::::  :   ::::::    :   :::       :   :         :      ]],
  [[      `:::::::::'   `::::::' .'   `:::::   .'   `::.     .'   `.       .'      ]],
  [[        `':::''       `'::'-'       `'::.-'       `':..-'       `-...-'        ]],
  [[                                                                               ]],
}
dashboard.section.buttons.val = {
  dashboard.button("o", icons.dashboard.Folder .. "  Open tree", ":NvimTreeToggle<CR>"),
  dashboard.button("o", icons.dashboard.Folder .. "  Open tree", ":NvimTreeToggle<CR>"),
  dashboard.button("f", icons.dashboard.Find .. "  Find file", ":FzfLua files<CR>"),
  dashboard.button("r", icons.dashboard.Time .. "  Recently used files", ":FzfLua oldfiles<CR>"),
  dashboard.button("g", icons.dashboard.Text .. "  Find text", ":FzfLua live_grep_glob<CR>"),
  dashboard.button("c", icons.dashboard.Setting .. "  Neovim Configuration", ":e $HOME/.config/nvim/ <CR>"),
  dashboard.button("t", icons.dashboard.Shell .. "  Kitty Configuration", ":e $HOME/.config/kitty/ <CR>"),
  dashboard.button("z", icons.dashboard.Shell .. "  Shell Configuration", ":e $HOME/.zshrc <CR>"),
  dashboard.button("q", icons.dashboard.Close .. "  Close Dashboard", ":q<CR>"),
  dashboard.button("Q", icons.dashboard.Quit .. "  Quit Neovim", ":qa<CR>"),
}

local function footer()
  return ":)"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

alpha.setup(dashboard.opts)
