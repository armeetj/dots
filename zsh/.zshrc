# p10k :: instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# config home :: path
export XDG_CONFIG_HOME="$HOME/.config"

# omz :: oh-my-zsh install path
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto      # update automatically without asking


# => Zsh Config
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# omz :: theme options: https://github.com/ohmyzsh/ohmyzsh/wiki/Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    zsh-autosuggestions
    you-should-use
    F-Sy-H
    fzf-tab
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ==> aliases 
alias cd="z"
alias t="tmux"
alias s="ssh"
alias v="nvim"
alias nvimdiff="nvim -d" # required by git config
alias c="code"
alias vim="nvim"
alias ff="fastfetch"
alias lg="lazygit"
alias ls="eza -T -L 1 --icons=auto --hyperlink -h -s type"

# ==> bookmarked aliases
function today() {
  nvim ~/sync/notes/daily/$(date +%m-%d-%y).md
}

alias ram="v ~/scratch/ram.md"
alias daily="v ~/sync/notes/daily"
# alias today="v ~/scratch/daily/$(date +%m-%d-%y).md"

# ==> config aliases
alias nvimc="nvim ~/.config/nvim/init.lua"
alias tmuxc="nvim ~/.tmux.conf"
alias kittyc="nvim ~/.config/kitty/kitty.conf"
alias zshc="nvim ~/.zshrc"
alias aerospacec="nvim ~/.config/aerospace/aerospace.toml"
alias sketchybarc="nvim ~/.config/sketchybar/sketchybarrc"
alias lazygitc="nvim ~/.config/lazygit/config.yml"
alias gitc="nvim ~/.gitconfig"

# ==> Configuration (local machine specific)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# p10k :: customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zoxide :: smarter cd
eval "$(zoxide init zsh)"

# fzf :: fuzzy search
source <(fzf --zsh)
source ~/.config/fzf/base16-mountain.sh

# fzf :: fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
# zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux integration
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS=" --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# yazi :: file manager
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ==> Keybindings

# zsh-autosuggestions
bindkey '^y' autosuggest-accept

# escape to clear suggestions
bindkey '\e' autosuggest-clear 

# history
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# idk what this does (maybe vim)
# bindkey -v
