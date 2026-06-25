vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("vim_pack_hooks", { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "update" then return end

    if name == "nvim-treesitter" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    elseif name == "telescope-fzf-native.nvim" then
      local path = ev.data.path
      vim.fn.system({ "make" }, path)
    elseif name == "kanagawa.nvim" then
      if not ev.data.active then vim.cmd.packadd("kanagawa.nvim") end
      vim.cmd("KanagawaCompile")
    elseif name == "LuaSnip" then
      if vim.fn.has("win32") == 0 and vim.fn.executable("make") == 1 then
        vim.fn.system({ "make", "install_jsregexp" }, ev.data.path)
      end
    end
  end,
})
