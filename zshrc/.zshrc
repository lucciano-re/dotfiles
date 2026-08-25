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

# convenient aliases
alias diff="diff --color=auto" #color diff default
alias del="rm -ri" #recursive(child directories) interactive(confirmation)
alias mv="mv -i" #interactive(confirm overwrite)
alias nv="nvim" #shortcut
alias df='df -h' #disc space human readable
alias free='free -m' #ram
alias ls="eza --icons" #change ls for high level (icons and colors) 
alias ll="eza -lh --icons --git"
alias la="eza -lah --icons --git"
alias cat="bat" #change cat for more modern and advanced
alias mkd="mkdir -p" #shortcut
alias cl="clear" #shortcut
alias find="fd -H" #change for feature rich and modern
alias fzf="fzf --preview 'bat --style=numbers --color=always {}'" #launch fuzzy finder
alias fuck="sudo pacman -Rs" #uninstall
alias install="sudo pacman -S"
alias audio="alsamixer" #shortcut
alias nvzsh="nv ~/.dotfiles/zshrc/.zshrc" # Updated this to point to zshrc
alias se="rg -S -. -C 2"  #search whith rip grep

alias drives='lsblk' #shortcut

alias spotdl='spotify-dl -t 4' #default 4 parrallel downloads 
# Git Aliases
alias gpush="git push"
alias gpull="git pull --prune"
alias gc="git commit -m"
alias ga="git add ."
alias fixgit-to-ssh='git remote set-url origin git@github.com:$(git remote get-url origin | sed "s/.*github.com[\/:]//;s/\.git$//").git'
alias lgit="lazygit"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export PATH=$PATH:/home/lucho/.spicetify

fastfetch
