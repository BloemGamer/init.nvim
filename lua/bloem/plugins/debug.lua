return
{
    {
    "mfussenegger/nvim-dap",
    dependencies =
    {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function ()
            require("mason-nvim-dap").setup(
            {
                ensure_installed =
                {
                    "cpptools",
                },
                automatic_installation = true,
            })

        local dap = require("dap")

        dap.adapters.cpptools = {
            id = "cppdbg",
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cpptools",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtEntry = true,
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
        }

        -- Optional: Alias for C
        dap.configurations.c = dap.configurations.cpp
    end


},
    {
        "rcarriga/nvim-dap-ui",
        dependencies =
            {
                "nvim-neotest/nvim-nio"
            },
        config = function ()
            require("dapui").setup()
            vim.keymap.set("n", "<leader>dt", ":lua require(\"dapui\").toggle()<CR>", {noremap=true})
            vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
            vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
            vim.keymap.set("n", "<leader>dr", ":lua require('dapui').open({reset=true})<CR>", {noremap=true})
            vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
            vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
            vim.keymap.set("n", "<F9>", function() require("dap").step_into() end)
            vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
        end


    },
    {
        "theHamsta/nvim-dap-virtual-text",
    },
}
