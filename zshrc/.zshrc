# If not running interactively, don't do anything (leave this at the top of this file)
[[ -o interactive ]] || return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)

autoload -Uz compinit
compinit

source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/you-should-use/you-should-use.plugin.zsh

eval "$(zoxide init zsh)"

# Make an alias for invoking commands you use constantly
# alias p='python'

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'

# Función para que Yazi cambie el directorio de la terminal al salir
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# rad's aliases
alias diff="diff --color=auto"
alias rm="rm -ri"
alias mv="mv -i"
alias nv="nvim"
alias df='df -h'
alias free='free -m'
alias ls="eza --icons"
alias ll="eza -lh --icons --git"
alias la="eza -lah --icons --git"
alias cat="bat"
alias -- -='cd -'
alias mkd="mkdir -p"
alias cl="clear"
alias cd="z"
alias find="fd -H"
alias fzf="fzf --preview 'bat --style=numbers --color=always {}'"
alias fuck="sudo pacman -Rs"
alias audio="alsamixer"
alias nvbash="nv dotfiles/zshrc/.zshrc" # Updated this to point to zshrc
alias se="rg -S -. -C 2"

alias arduino-ide='arduino-ide --no-sandbox --disable-gpu --ozone-platform=x11'

# Git Aliases
alias gpush="git push"
alias gpull="git pull --prune"
alias gc="git commit -m"
alias ga="git add ."
alias fixgit-to-ssh='git remote set-url origin git@github.com:$(git remote get-url origin | sed "s/.*github.com[\/:]//;s/\.git$//").git'

export PATH=$PATH:/home/luchho/.spicetify
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"



export PATH=$PATH:/home/lucho/.spicetify
fastfetch
