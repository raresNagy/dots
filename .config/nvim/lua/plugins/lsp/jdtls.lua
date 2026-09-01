return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mason-org/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	init = function()
		require("mason-tool-installer").setup({ ensure_installed = { "jdtls", "java-test" } })
		vim.api.nvim_create_user_command("JavaTestScaffold", function()
			require("jdtls.tests").generate()
		end, {})
		vim.keymap.set("n", "<leader>jt", "<cmd>JavaTestScaffold<cr>", { desc = "Generate Java test scaffold" })
	end,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("jdtls", { clear = true }),
			pattern = "java",
			callback = function()
				local jdtls = require("jdtls")

				local root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
				if not root_dir then
					return
				end

				local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
				local workspace_dir = vim.fn.stdpath("data") .. "/site/java-workspace/" .. project_name

				local mason_registry = require("mason-registry")
				local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
				local java_test_path = mason_registry.get_package("java-test"):get_install_path()

				local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
				local config_dir = jdtls_path .. "/config_" .. (vim.fn.has("mac") == 1 and "mac" or "linux")
				local bundles = {}
				for _, pattern in ipairs({
					java_test_path .. "/java-test/*.jar",
					java_test_path .. "/extension/server/*.jar",
				}) do
					vim.list_extend(bundles, vim.split(vim.fn.glob(pattern, 1), "\n"))
				end
				bundles = vim.tbl_filter(function(b)
					return b ~= ""
				end, bundles)

				local config = {
					cmd = {
						"java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.level=ALL",
						"-Xmx2g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",
						"-jar",
						launcher_jar,
						"-configuration",
						config_dir,
						"-data",
						workspace_dir,
					},
					root_dir = root_dir,
					init_options = {
						extendedClientCapabilities = jdtls.extendedClientCapabilities,
						bundles = bundles,
					},
				}

				jdtls.start_or_attach(config)
			end,
		})
	end,
}
