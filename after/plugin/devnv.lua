local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local function tmux_pane_entries(panes)
    table.sort(panes, function(left, right)
        return left < right
    end)

    local entries = {}

    for _, pane in ipairs(panes) do
        local parts = vim.split(pane, "|", { plain = true })
        local target = parts[1]

        table.insert(entries, {
            kind = "pane",
            target = target,
            command = parts[2],
            path = parts[3],
            active = parts[4],
        })
    end

    return entries
end

local function find_tmux_pane()
    if vim.env.TMUX == nil then
        vim.notify("Not running inside tmux", vim.log.levels.WARN)
        return
    end

    local current_session = vim.fn.systemlist({ "tmux", "display-message", "-p", "#{session_name}" })[1]
    if vim.v.shell_error ~= 0 or current_session == nil or current_session == "" then
        vim.notify("Could not detect current tmux session", vim.log.levels.WARN)
        return
    end

    local panes = vim.fn.systemlist({
        "tmux",
        "list-panes",
        "-s",
        "-t",
        current_session,
        "-F",
        "#{session_name}:#{window_index}.#{pane_index}|#{pane_current_command}|#{pane_current_path}|#{pane_active}",
    })

    if vim.v.shell_error ~= 0 or vim.tbl_isempty(panes) then
        vim.notify("No tmux panes found", vim.log.levels.WARN)
        return
    end

    pickers.new({}, {
        prompt_title = "Tmux panes",
        finder = finders.new_table({
            results = tmux_pane_entries(panes),
            entry_maker = function(entry)
                local marker = entry.active == "1" and "* " or "  "

                return {
                    value = entry,
                    display = string.format("%s%-10s %-12s %s", marker, entry.target, entry.command, entry.path),
                    ordinal = string.format("%s %s %s", entry.target, entry.command, entry.path),
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if selection then
                    vim.fn.system({ "tmux", "switch-client", "-t", selection.value.target })
                end
            end)

            return true
        end,
    }):find()
end

vim.keymap.set('n', '<leader>pt', find_tmux_pane, { desc = "Find tmux pane" })
