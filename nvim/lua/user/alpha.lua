local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require("user.icons")

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[                                                                               ]],
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
  dashboard.button("o", icons.dashboard.Folder  .. "  Open tree", ":NvimTreeToggle <CR>"),
  dashboard.button("f", icons.dashboard.Find    .. "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", icons.dashboard.File    .. "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", icons.dashboard.Time    .. "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", icons.dashboard.Text    .. "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", icons.dashboard.Setting .. "  Neovim Configuration", ":e $HOME/.config/nvim/ <CR>"),
  dashboard.button("z", icons.dashboard.Shell   .. "  Shell Configuration", ":e $HOME/.zshrc <CR>"),
  dashboard.button("q", icons.dashboard.Close   .. "  Close Dashboard", ":q<CR>"),
  dashboard.button("Q", icons.dashboard.Quit    .. "  Quit Neovim", ":qa<CR>"),
}

local function footer()
  return ":)"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
