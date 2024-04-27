local file = require("cass.utils.file")

local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

local dapui_status, dapui = pcall(require, "dapui")
if not dapui_status then
	return
end

-- open/close the dap ui based on some events
-- dap.listeners.before.attach["dapui_config"] = function()
-- 	dapui.open()
-- end
-- dap.listeners.before.launch["dapui_config"] = function()
-- 	dapui.open()
-- end
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dapui.setup()

-- setup debugging configurations
-- configuration setup was coppied from https://github.com/Civitasv/runvim/blob/d449ce01db37e4977472d51c50c3ab0a651c0ccd/lua/plugins/%2Bdap.lua#L82
dap.configurations.cpp = {
	{
		name = "C++ Debug And Run",
		type = "codelldb",
		request = "launch",
		program = function()
			-- First, check if exists CMakeLists.txt
			local cwd = vim.fn.getcwd()
			if file.exists(cwd, "CMakeLists.txt") then
				-- TODO: Then invoke cmake commands
				-- Then ask user to provide execute file
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			else
				local fileName = vim.fn.expand("%:t:r")
				-- create this directory
				os.execute("mkdir -p " .. "bin")
				local cmd = "!g++ -g % -o bin/" .. fileName
				-- First, compile it
				vim.cmd(cmd)
				-- Then, return it
				return "${fileDirname}/bin/" .. fileName
			end
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		runInTerminal = true,
		console = "integratedTerminal",
	},
}

-- only on macos
local codelldb_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb"

dap.adapters.codelldb = {
	type = "server",
	-- host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = codelldb_path,
		args = { "--port", "${port}" },
	},
}

vim.keymap.set("n", "<Leader>dc", dap.continue, {
	desc = "Start or Continue from current breakpoint",
})
vim.keymap.set("n", "<Leader>dn", dap.step_over, {
	desc = "Step over",
})
vim.keymap.set("n", "<Leader>di", dap.step_into, {
	desc = "Step into",
})
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {
	desc = "Toggle breakpoint",
})
vim.keymap.set("n", "<Leader>dbc", function()
	dap.set_breakpoint(vim.fn.input("condition: "), nil, nil)
end, {
	desc = "Set breakpoint condition",
})
vim.keymap.set("n", "<Leader>dC", function()
	dap.clear_breakpoints()
end)
