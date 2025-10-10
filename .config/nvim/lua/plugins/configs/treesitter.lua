return {
  ensure_installed = {
    "go",
    "cpp",
    "lua",
    "rust",
    "python",
    "html",
    -- twig is sometimes useful for template-like syntax; add as optional
    "twig",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
}
