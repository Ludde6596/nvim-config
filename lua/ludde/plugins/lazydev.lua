return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      vim.fn.stdpath("config") .. "/lua",
    },
    enabled = function(root_dir)
      local nvim_config = vim.fn.stdpath("config")
      return root_dir == nvim_config or root_dir:sub(1, #nvim_config + 1) == nvim_config .. "/"
    end,
  },
}
