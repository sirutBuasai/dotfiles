local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

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
  dashboard.button("o", "  Open tree", ":NvimTreeToggle <CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Neovim Configuration", ":e $HOME/.config/nvim/ <CR>"),
  dashboard.button("z", "  Shell Configuration", ":e $HOME/.zshrc <CR>"),
  dashboard.button("q", "蘒 Close Dashboard", ":q<CR>"),
  dashboard.button("Q", "  Quit Neovim", ":qa<CR>"),
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
