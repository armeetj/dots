# ===========
# fish - 2025
#  by @armeet
# ===========

set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux EDITOR "nvim"

# fish :: local config
#if test -f ~/.config/fish/config.local.fish
#    source ~/.config/fish/config.local.fish
#end

# zoxide :: smarter cd
zoxide init fish | source

# fzf :: fuzzy finding
set -Ux FZF_CTRL_T_OPTS "
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
set -Ux FZF_CTRL_R_OPTS "
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# fzf :: jobs fg (foreground resume)
function fzf_fg
    set job_info (jobs | fzf --height=10 --border --min-height=5 --no-info --prompt="Select job: ")

    set job (echo $job_info | awk '{print $1}' | tr -d '[]')  # Extract job ID without brackets
    if test -n "$job"
        commandline -f repaint  # Redraw command line after fzf
        fg %$job
    end
end

bind \cj fzf_fg

# aliases :: executables
function cd; z $argv; end
function t; tmux $argv; end
function s; ssh $argv; end
function v; nvim $argv; end
function nvimdiff; nvim -d $argv; end
function c; code $argv; end
function ff; fastfetch $argv; end
function lg; lazygit $argv; end
function ls; eza $argv; end
function l; eza -lah --icons=auto --hyperlink -s type $argv; end

# aliases :: bookmarks 
function today
    set date_str (date +%m-%d-%y)
    set today_file ~/sync/notes/daily/$date_str.md
    if not test -f $today_file
        echo 'in here'
        printf "# %s\n\n# important\n- " $date_str > $today_file
    end
    nvim $today_file
end
function ram; nvim ~/scratch/ram.md; end
function daily; nvim ~/sync/notes/daily; end

# aliases :: config
function nvimc; nvim ~/.config/nvim/init.lua; end
function tmuxc; nvim ~/.tmux.conf; end
function kittyc; nvim ~/.config/kitty/kitty.conf; end
function fishc; nvim ~/.config/fish/config.fish; end
function fishlc; nvim ~/.config/fish/config.local.fish; end
function zshc; nvim ~/.zshrc; end
function aerospacec; nvim ~/.config/aerospace/aerospace.toml; end
function sketchybarc; nvim ~/.config/sketchybar/sketchybarrc; end
function lazygitc; nvim ~/.config/lazygit/config.yml; end
function gitc; nvim ~/.gitconfig; end
function i3c; nvim ~/.config/i3/config; end
function picomc; nvim ~/.config/picom/picom.conf; end
function polybarc; nvim ~/.config/polybar/config.ini; end

# aliases :: environment 
function uvs; source .venv/bin/activate.fish; end

# conda :: init
#if test -f /Users/armeetjatyani/anaconda3/bin/conda
#    eval /Users/armeetjatyani/anaconda3/bin/conda "shell.fish" "hook" $argv | source
#end
