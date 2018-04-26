# first arg is the pattern to search
ls0() { gs | awk '/'"$1"'/ {print $0}'; }
ls1() { gs | awk '/'"$1"'/ {print $1}'; }
ls2() { gs | awk '/'"$1"'/ {print $2}'; }
# second arg is the column to display
lsn() { gs | awk '/'"$1"'/ {print $'"$2"'}'; }

cp_l() { history | tail -n 2 | head -n 1 | awk '{ for (i = 2; i < NF; i++) printf $i " "; print $NF }' | clip; }

bk() { cd "$OLDPWD"; }

# join lines in a text file
jn() { awk 'NF == 0 { printf("\n\n"); next; } { printf("%s ", $0) }' "$1"; }

settitle () { echo -ne "\e]2;$@\a\e]1;$@\a"; }

# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func () {
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias cd=cd_func

extract () {
  if [[ -f "$1" ]]
  then
    case "$1" in
      *.tar.bz2)   tar xvjf "$1"    ;;
      *.tar.gz)    tar xvzf "$1"    ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xvf "$1"     ;;
      *.tbz2)      tar xvjf "$1"    ;;
      *.tgz)       tar xvzf "$1"    ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "don't know how to extract $1..." ;;
    esac
  else
    echo "$1 is not a valid file!"
  fi
}


browse() {
  repo="$(sed -rn "/\[remote.*origin.*]/,/^(\[|$)/ { /url/s/^.*:\/?([^\.]*).*$/\1/p }" .git/config)"
  chrome "https://github.com/$repo"
}
