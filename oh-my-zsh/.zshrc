# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# --- Aliases --- #

# edit configurations
alias zshconfig="vim ~/.zshrc"
alias gitconfig="vim ~/.gitconfig"
alias vimconfig="vim ~/.vimrc"

# Git alias
alias checkout="git checkout $1"
alias pull="git pull origin $1"
alias push="git push origin $1"
alias fetch="git fetch"
alias glog="git lg $1" 

# Directory alias
alias work="cd $HOME/Workspace"

# AWS variables
export AWS_STAGING_PROFILE=staging
export AWS_PRD_PROFILE=prd
export AWS_STAGING_CLUSTER=STAGING-CLUSTER
export AWS_PRD_CLUSTER=PRD-CLUSTER

# AWS alias
awsv() { aws-vault exec "$@" --debug  --duration=1h -- ~/.aws/setprofile.pl;}
alias awsvlp="aws-vault list --profiles"
alias awsci="aws sts get-caller-identity"
alias awslogin="aws clear && aws login $1" 

# change environment alias
alias staging="awsv $AWS_STAGING_PROFILE"
alias prd="awsv $AWS_PRD_PROFILE"

# kubernetes autocomplete
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# kubernetes alias
alias k="kubectl"

alias k8s_staging="staging \
	&& aws eks update-kubeconfig --region us-east-1 --name $AWS_STAGING_CLUSTER \
	&& aws eks get-token --cluster-name $AWS_STAGING_CLUSTER \
	| awk -F '\"token\":' '{print \$2}' | awk -F '}' '{print \$1}' | sed 's/\"//g;s/^\ //g' \
	| pbcopy && k config set-context --current --namespace=hml"

alias k8s_prd="prd \
	&& aws eks update-kubeconfig --region sa-east-1 --name $AWS_PRD_CLUSTER \
	&& aws eks get-token --cluster-name $AWS_PRD_CLUSTER \
	| awk -F '\"token\":' '{print \$2}' | awk -F '}' '{print \$1}' | sed 's/\"//g;s/^\ //g' \
	| pbcopy && k config set-context --current --namespace=prd"

# Java Configuration
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH=$PATH:$JAVA_HOME/bin

M2_HOME=/opt/apache-maven-3.9.9
export PATH=$PATH:$M2_HOME/bin

jdk() {
     version=$1
     unset JAVA_HOME;
     export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
     java -version
}

# starship terminal theme
eval "$(starship init zsh)"

# Python
export PATH="$(brew --prefix python)/libexec/bin:$PATH"


