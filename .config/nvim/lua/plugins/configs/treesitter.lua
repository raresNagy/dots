return {
  ensure_installed = {
    "go",
    "cpp",
    "lua",
    "rust",
    "python",
    "html",
    "css",
    -- twig is sometimes useful for template-like syntax; add as optional
    "twig",
    "c_sharp",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
}
