return {
  "ThyW/todotxt.nvim",
  requires = { "MunifTanjim/nui.nvim" },
  branch = "vim-ui-input",
  config = function()
    require("todotxt-nvim").setup({
      todo_file = "~/Notes/todo.todo.txt",
    })
  end,
}
