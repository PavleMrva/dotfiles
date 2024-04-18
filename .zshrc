# Set configuration directory
export XDG_CONFIG_HOME="$HOME/.config"
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# ZSH Theme Configuration
ZSH_THEME="jbergantine"

# Oh-My-Zsh Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Initialize nvm, Docker, and bun configurations
export NVM_DIR="$HOME/.nvm"
export DOCKER_DEFAULT_PLATFORM="linux/amd64"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && source "$(brew --prefix nvm)/nvm.sh"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun Installation
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Google Cloud SDK
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"; fi

# Kubernetes configurations
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export KUBE_EDITOR="nvim"
export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/prod-k8s-5star.ini:$HOME/.kube/cms-stage-config:$HOME/.kube/cms-prod-config:$HOME/.kube/go-test-aws-config"
source <(kubectl completion zsh)

# GVM (Go Version Manager)
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Go environment
export GOPRIVATE="bitbucket.org/autautdoo/*"
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export GOPROXY="https://proxy.golang.org"

# Neovim and Mason
export MASON_PATH="$HOME/.local/share/nvim/mason"
export PATH="$MASON_PATH/bin:$PATH"

# Aliases for convenience
alias python="python3"
alias pip="pip3"
alias vim="nvim"
alias k="kubectl"
alias kg="kubectl get"
alias ke="kubectl edit"
alias kc="kubectl create"
alias kd="kubectl describe"
alias krm="kubectl delete"
alias setns="kubectl config set-context --current --namespace"

# Labels and dry-run shortcuts for Kubernetes
export sl="--show-labels"
export do="--dry-run=client -oyaml"

# Load custom Powerlevel10k theme configuration if it exists
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

export MOJO_PYTHON_LIBRARY=/Users/Pavle/miniconda3/lib/libpython3.11.dylib

# use python 3.11 for gcloud
export CLOUDSDK_PYTHON=/Library/Frameworks/Python.framework/Versions/3.11/bin/python3
