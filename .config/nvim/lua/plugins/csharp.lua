return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    opts = {
      filewatching = "roslyn", -- let roslyn handle filewatching for better perf
      broad_search = true, -- search parent dirs for .sln (great for monorepos)
      lock_target = false, -- allow switching solutions with :Roslyn target
      config = {
        -- LSP server settings forwarded to Roslyn
        ["csharp|background_analysis|analyzer_diagnostics_scope"] = "openFiles",
        ["csharp|background_analysis|compiler_diagnostics_scope"] = "openFiles",
        ["csharp|inlay_hints|enable_inlay_hints_for_types"] = true,
        ["csharp|inlay_hints|enable_inlay_hints_for_parameters"] = true,
        ["csharp|completion|show_completion_items_from_unimported_namespaces"] = true,
        ["csharp|code_lens|enable_references_code_lens"] = true,
      },
    },

    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
