local M = {}

M.find_git_root = function()
  local current_file = vim.api.nvim_buf_get_name(0)

  local current_dir
  local cwd = vim.fn.getcwd()
  if current_file == "" then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 then
    return nil
  end
  return git_root
end

return M
