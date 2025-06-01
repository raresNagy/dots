return {
  "mfussenegger/nvim-dap",
  ft = "go",
  config = function(_, opts)
    require("dap-go").setup(opts)
  end,
}
