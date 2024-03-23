local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

local lualine = require("lualine")

lualine.setup({
  options = {
    icons_enabled = true,
    component_separators = "|",
    section_separators = "",
    theme = _G.theme,
  },
  sections = {
    lualine_x = {
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      },
    },
    lualine_a = {
      {
        "buffers",
      },
    },

    lualine_b = {
      {
        "macro-recording",
        fmt = show_macro_recording,
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 1,
      },
    },
  },
})

-- vim.api.nvim_create_autocmd("RecordingEnter", {
--   callback = function()
--     lualine.refresh({
--       place = { "statusline" },
--     })
--   end,
-- })

-- vim.api.nvim_create_autocmd("RecordingLeave", {
--   callback = function()
--     -- This is going to seem really weird!
--     -- Instead of just calling refresh we need to wait a moment because of the nature of
--     -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
--     -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
--     -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
--     -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
--     local timer = vim.loop.new_timer()
--     timer:start(
--       50,
--       0,
--       vim.schedule_wrap(function()
--         lualine.refresh({
--           place = { "statusline" },
--         })
--       end)
--     )
--   end,
-- })
