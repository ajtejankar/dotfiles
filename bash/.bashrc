# for a complete list of shell options
# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html

# http://unix.stackexchange.com/questions/34011/the-best-way-to-expand-glob-pattern
# for more information visit the above url
shopt -s extglob
shopt -s globstar
shopt -s nullglob

shopt -s cdspell

# for complete bash history hacks
# http://www.catonmat.net/blog/the-definitive-guide-to-bash-command-line-history/
shopt -s histappend
shopt -s histreedit

# git abbreviations
alias gs='git status '
alias go='git checkout '
alias ga='git add '
alias gc='git commit '
alias gb='git branch '
alias gd='git diff '
alias gl='git log '
alias gf='git fetch '
alias gcp='git cherry-pick '
alias gr='git rebase '
alias pcf='git cat-file'
alias gdc='git diff --cached '

# git quick commands
alias grod='git rebase origin/develop'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grs='git rebase --skip'

alias gp='git push origin HEAD '

alias gpr='git pull --rebase '

alias goa='git checkout -- .'

alias gca='git commit --amend '
alias gcan='git commit --amend --no-edit '

alias gserv='git daemon --verbose --export-all --base-path=.'
alias gbup='git branch --set-upstream-to '

# start the jekyll server
alias js='bundle exec jekyll serve'

# misc
alias c="clear"
alias st='sublime_text.exe '
alias ls='ls --color=auto '
alias ll='ls --color=auto -l '
alias la='ls --color=auto -al '
alias grep='grep --color=auto '
alias sb='st ~/.bashrc'
alias vi='vim '
alias po='polyserve -o '

# directory shortcuts
source ~/.dir_shortcuts.bash
source ~/Dropbox/dotfiles/colors.bash
source ~/Dropbox/dotfiles/functions.bash

# git configuration
# documentation for the following can be found in /etc/git-prompt.sh
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWCOLORHINTS=1
source ~/Dropbox/dotfiles/prompt.bash

# start ssh agent
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

if [[ -f ~/.ssh/gitlab ]]; then
	ssh-add ~/.ssh/gitlab
fi

# added by travis gem
[ -f C:/Users/ajinkya/.travis/travis.sh ] && source C:/Users/ajinkya/.travis/travis.sh

PATH="$PATH:./bin:./node_modules/.bin"
PATH="$PATH:$CODES_DIR/notes"
PATH="$PATH:~/Dropbox/work/bash-scripts"

eval "$(hub alias -s)"

# added by the script at /d/atom-project/utils/install
export UTIL_INSTALL_DIR="$ATOM_PROJECT/utils"
PATH=$PATH:"$ATOM_PROJECT/utils"
##### script end ######
