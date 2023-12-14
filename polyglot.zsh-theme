# ------------------------------------------------------------------------------
# CONFIGURATION
# The default configuration, that can be overwrite in your .zshrc file
# ------------------------------------------------------------------------------

VIRTUAL_ENV_DISABLE_PROMPT=true
DISABLE_UNICODE_PROMPT=false

# Define order and content of prompt
if [ ! -n "${POLYGLOT_PROMPT_ORDER+1}" ]; then
  POLYGLOT_PROMPT_ORDER=(
    time
    status
    context
    dir
    aws
    ruby
    java
    nvm
    go
    rust
    dotnet
    virtualenv
    git
    cmd_exec_time
  )
fi

# PROMPT
if [ ! -n "${POLYGLOT_PROMPT_CHAR+1}" ]; then
  POLYGLOT_PROMPT_CHAR="\$ >"
fi
if [ ! -n "${POLYGLOT_PROMPT_ROOT+1}" ]; then
  POLYGLOT_PROMPT_ROOT=true
fi
if [ ! -n "${POLYGLOT_PROMPT_SEPARATE_LINE+1}" ]; then
  POLYGLOT_PROMPT_SEPARATE_LINE=true
fi
if [ ! -n "${POLYGLOT_PROMPT_ADD_NEWLINE+1}" ]; then
  POLYGLOT_PROMPT_ADD_NEWLINE=true
fi

# STATUS
if [ ! -n "${POLYGLOT_STATUS_EXIT_SHOW+1}" ]; then
  POLYGLOT_STATUS_EXIT_SHOW=false
fi
if [ ! -n "${POLYGLOT_STATUS_BG+1}" ]; then
  POLYGLOT_STATUS_BG=green
fi
if [ ! -n "${POLYGLOT_STATUS_ERROR_BG+1}" ]; then
  POLYGLOT_STATUS_ERROR_BG=red
fi
if [ ! -n "${POLYGLOT_STATUS_FG+1}" ]; then
  POLYGLOT_STATUS_FG=white
fi

# TIME
if [ ! -n "${POLYGLOT_TIME_BG+1}" ]; then
  POLYGLOT_TIME_BG=white
fi
if [ ! -n "${POLYGLOT_TIME_FG+1}" ]; then
  POLYGLOT_TIME_FG=black
fi

# VIRTUALENV
if [ ! -n "${POLYGLOT_VIRTUALENV_BG+1}" ]; then
  POLYGLOT_VIRTUALENV_BG=yellow
fi
if [ ! -n "${POLYGLOT_VIRTUALENV_FG+1}" ]; then
  POLYGLOT_VIRTUALENV_FG=white
fi
if [ ! -n "${POLYGLOT_VIRTUALENV_PREFIX+1}" ]; then
  POLYGLOT_VIRTUALENV_PREFIX=🐍
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    POLYGLOT_VIRTUALENV_PREFIX="PY"
  fi
fi

# NVM
if [ ! -n "${POLYGLOT_NVM_BG+1}" ]; then
  POLYGLOT_NVM_BG=green
fi
if [ ! -n "${POLYGLOT_NVM_FG+1}" ]; then
  POLYGLOT_NVM_FG=white
fi
if [ ! -n "${POLYGLOT_NVM_PREFIX+1}" ]; then
  POLYGLOT_NVM_PREFIX="⬡ "
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    POLYGLOT_NVM_PREFIX="NODE "
  fi
fi

# AWS
if [ ! -n "${POLYGLOT_AWS_BG+1}" ]; then
  POLYGLOT_AWS_BG=yellow
fi
if [ ! -n "${POLYGLOT_AWS_FG+1}" ]; then
  POLYGLOT_AWS_FG=black
fi
if [ ! -n "${POLYGLOT_AWS_PREFIX+1}" ]; then
  POLYGLOT_AWS_PREFIX="☁️"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    POLYGLOT_AWS_PREFIX="AWS"
  fi
fi

# RUBY
if [ ! -n "${POLYGLOT_RUBY_BG+1}" ]; then
  POLYGLOT_RUBY_BG=red
fi
if [ ! -n "${POLYGLOT_RUBY_FG+1}" ]; then
  POLYGLOT_RUBY_FG=white
fi
if [ ! -n "${POLYGLOT_RUBY_PREFIX+1}" ]; then
  POLYGLOT_RUBY_PREFIX="♦️"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    POLYGLOT_RUBY_PREFIX="RB"
  fi
fi

# Go
if [ ! -n "${POLYGLOT_GO_BG+1}" ]; then
  POLYGLOT_GO_BG=cyan
fi
if [ ! -n "${POLYGLOT_GO_FG+1}" ]; then
  POLYGLOT_GO_FG=white
fi
if [ ! -n "${POLYGLOT_GO_PREFIX+1}" ]; then
  POLYGLOT_GO_PREFIX="GO"
fi

# Java
if [ ! -n "${POLYGLOT_JAVA_BG+1}" ]; then
  POLYGLOT_JAVA_BG=red
fi
if [ ! -n "${POLYGLOT_JAVA_FG+1}" ]; then
  POLYGLOT_JAVA_FG=white
fi
if [ ! -n "${POLYGLOT_JAVA_PREFIX+1}" ]; then
  POLYGLOT_JAVA_PREFIX="☕"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    POLYGLOT_JAVA_PREFIX="JDK"
  fi
fi

# Rust
if [ ! -n "${POLYGLOT_RUST_BG+1}" ]; then
  POLYGLOT_RUST_BG=red
fi
if [ ! -n "${POLYGLOT_RUST_FG+1}" ]; then
  POLYGLOT_RUST_FG=white
fi
if [ ! -n "${POLYGLOT_RUST_PREFIX+1}" ]; then
  POLYGLOT_RUST_PREFIX="🦀"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    POLYGLOT_RUST_PREFIX="RUST"
  fi
fi

# Dotnet
if [ ! -n "${POLYGLOT_DOTNET_BG+1}" ]; then
  POLYGLOT_DOTNET_BG=blue
fi
if [ ! -n "${POLYGLOT_DOTNET_FG+1}" ]; then
  POLYGLOT_DOTNET_FG=red
fi
if [ ! -n "${POLYGLOT_DOTNET_PREFIX+1}" ]; then
  POLYGLOT_DOTNET_PREFIX=".NET"
fi

# DIR
if [ ! -n "${POLYGLOT_DIR_BG+1}" ]; then
  POLYGLOT_DIR_BG=blue
fi
if [ ! -n "${POLYGLOT_DIR_FG+1}" ]; then
  POLYGLOT_DIR_FG=white
fi
if [ ! -n "${POLYGLOT_DIR_CONTEXT_SHOW+1}" ]; then
  POLYGLOT_DIR_CONTEXT_SHOW=false
fi
if [ ! -n "${POLYGLOT_DIR_EXTENDED+1}" ]; then
  POLYGLOT_DIR_EXTENDED=1
fi

# GIT
if [ ! -n "${POLYGLOT_GIT_COLORIZE_DIRTY+1}" ]; then
  POLYGLOT_GIT_COLORIZE_DIRTY=false
fi
if [ ! -n "${POLYGLOT_GIT_COLORIZE_DIRTY_FG_COLOR+1}" ]; then
  POLYGLOT_GIT_COLORIZE_DIRTY_FG_COLOR=black
fi
if [ ! -n "${POLYGLOT_GIT_COLORIZE_DIRTY_BG_COLOR+1}" ]; then
  POLYGLOT_GIT_COLORIZE_DIRTY_BG_COLOR=yellow
fi
if [ ! -n "${POLYGLOT_GIT_BG+1}" ]; then
  POLYGLOT_GIT_BG=white
fi
if [ ! -n "${POLYGLOT_GIT_FG+1}" ]; then
  POLYGLOT_GIT_FG=black
fi
if [ ! -n "${POLYGLOT_GIT_EXTENDED+1}" ]; then
  POLYGLOT_GIT_EXTENDED=true
fi
if [ ! -n "${POLYGLOT_GIT_PROMPT_CMD+1}" ]; then
  POLYGLOT_GIT_PROMPT_CMD="\$(git_prompt_info)"
fi

# CONTEXT
if [ ! -n "${POLYGLOT_CONTEXT_BG+1}" ]; then
  POLYGLOT_CONTEXT_BG=magenta
fi
if [ ! -n "${POLYGLOT_CONTEXT_FG+1}" ]; then
  POLYGLOT_CONTEXT_FG=white
fi
if [ ! -n "${POLYGLOT_CONTEXT_HOSTNAME+1}" ]; then
  POLYGLOT_CONTEXT_HOSTNAME=%m
fi

# GIT PROMPT
if [ ! -n "${POLYGLOT_GIT_PREFIX+1}" ]; then
  ZSH_THEME_GIT_PROMPT_PREFIX="git: "
else
  ZSH_THEME_GIT_PROMPT_PREFIX=$POLYGLOT_GIT_PREFIX
fi

if [ ! -n "${POLYGLOT_GIT_SUFFIX+1}" ]; then
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
else
  ZSH_THEME_GIT_PROMPT_SUFFIX=$POLYGLOT_GIT_SUFFIX
fi

if [ ! -n "${POLYGLOT_GIT_DIRTY+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✘%F{black}"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}(dirty)%F{black}"
  fi
else
  ZSH_THEME_GIT_PROMPT_DIRTY=$POLYGLOT_GIT_DIRTY
fi

if [ ! -n "${POLYGLOT_GIT_CLEAN+1}" ]; then
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✔%F{black}"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}(clean)%F{black}"
  fi
else
  ZSH_THEME_GIT_PROMPT_CLEAN=$POLYGLOT_GIT_CLEAN
fi

if [ ! -n "${POLYGLOT_GIT_ADDED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}✚%F{black}"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}+%F{black}"
  fi
else
  ZSH_THEME_GIT_PROMPT_ADDED=$POLYGLOT_GIT_ADDED
fi

if [ ! -n "${POLYGLOT_GIT_MODIFIED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{blue}✹%F{black}"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{blue}≈%F{black}"
  fi
else
  ZSH_THEME_GIT_PROMPT_MODIFIED=$POLYGLOT_GIT_MODIFIED
fi

if [ ! -n "${POLYGLOT_GIT_DELETED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}✖%F{black}"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}-%F{black}"
  fi
else
  ZSH_THEME_GIT_PROMPT_DELETED=$POLYGLOT_GIT_DELETED
fi

if [ ! -n "${POLYGLOT_GIT_UNTRACKED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}✭%F{black}"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}?!%F{black}"
  fi
else
  ZSH_THEME_GIT_PROMPT_UNTRACKED=$POLYGLOT_GIT_UNTRACKED
fi

if [ ! -n "${POLYGLOT_GIT_RENAMED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_RENAMED=" ->"
else
  ZSH_THEME_GIT_PROMPT_RENAMED=$POLYGLOT_GIT_RENAMED
fi

if [ ! -n "${POLYGLOT_GIT_UNMERGED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_UNMERGED=" ="
else
  ZSH_THEME_GIT_PROMPT_UNMERGED=$POLYGLOT_GIT_UNMERGED
fi

if [ ! -n "${POLYGLOT_GIT_AHEAD+1}" ]; then
  ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_AHEAD=" »"
  fi
else
  ZSH_THEME_GIT_PROMPT_AHEAD=$POLYGLOT_GIT_AHEAD
fi

if [ ! -n "${POLYGLOT_GIT_BEHIND+1}" ]; then
  ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_BEHIND=" «"
  fi
else
  ZSH_THEME_GIT_PROMPT_BEHIND=$POLYGLOT_GIT_BEHIND
fi

if [ ! -n "${POLYGLOT_GIT_DIVERGED+1}" ]; then
  ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"
  if [[ $DISABLE_UNICODE_PROMPT == true ]]; then
    ZSH_THEME_GIT_PROMPT_DIVERGED=" ±"
  fi
else
  ZSH_THEME_GIT_PROMPT_DIVERGED=$POLYGLOT_GIT_PROMPT_DIVERGED
fi

# COMMAND EXECUTION TIME
if [ ! -n "${POLYGLOT_EXEC_TIME_ELAPSED+1}" ]; then
  POLYGLOT_EXEC_TIME_ELAPSED=5
fi
if [ ! -n "${POLYGLOT_EXEC_TIME_BG+1}" ]; then
  POLYGLOT_EXEC_TIME_BG=yellow
fi
if [ ! -n "${POLYGLOT_EXEC_TIME_FG+1}" ]; then
  POLYGLOT_EXEC_TIME_FG=black
fi


# ------------------------------------------------------------------------------
# SEGMENT DRAWING
# A few functions to make it easy and re-usable to draw segmented prompts
# ------------------------------------------------------------------------------

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Takes three arguments, background, foreground and text. All of them can be omitted,
# rendering default background/foreground and no text.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# ------------------------------------------------------------------------------
# PROMPT COMPONENTS
# Each component will draw itself, and hide itself if no information needs
# to be shown
# ------------------------------------------------------------------------------

# Context: user@hostname (who am I and where am I)
context() {
  local user="$(whoami)"
  [[ "$user" != "$POLYGLOT_CONTEXT_DEFAULT_USER" || -n "$POLYGLOT_IS_SSH_CLIENT" ]] && echo -n "${user}@$POLYGLOT_CONTEXT_HOSTNAME"
}

prompt_context() {
  local _context="$(context)"
  [[ -n "$_context" ]] && prompt_segment $POLYGLOT_CONTEXT_BG $POLYGLOT_CONTEXT_FG "$_context"
}

# Based on http://stackoverflow.com/a/32164707/3859566
function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%dd' $D
  [[ $H > 0 ]] && printf '%dh' $H
  [[ $M > 0 ]] && printf '%dm' $M
  printf '%ds' $S
}

# Prompt previous command execution time
preexec() {
  cmd_timestamp=`date +%s`
}

precmd() {
  local stop=`date +%s`
  local start=${cmd_timestamp:-$stop}
  let POLYGLOT_last_exec_duration=$stop-$start
  cmd_timestamp=''
}

prompt_cmd_exec_time() {
  [ $POLYGLOT_last_exec_duration -gt $POLYGLOT_EXEC_TIME_ELAPSED ] && prompt_segment $POLYGLOT_EXEC_TIME_BG $POLYGLOT_EXEC_TIME_FG "$(displaytime $POLYGLOT_last_exec_duration)"
}

# Git
prompt_git() {
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" == "1" ]]; then
    return
  fi

  local ref dirty mode repo_path git_prompt
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    if [[ $POLYGLOT_GIT_COLORIZE_DIRTY == true && -n $(git status --porcelain --ignore-submodules) ]]; then
      POLYGLOT_GIT_BG=$POLYGLOT_GIT_COLORIZE_DIRTY_BG_COLOR
      POLYGLOT_GIT_FG=$POLYGLOT_GIT_COLORIZE_DIRTY_FG_COLOR
    fi
    prompt_segment $POLYGLOT_GIT_BG $POLYGLOT_GIT_FG

    eval git_prompt=${POLYGLOT_GIT_PROMPT_CMD}
    if [[ $POLYGLOT_GIT_EXTENDED == true ]]; then
      echo -n ${git_prompt}$(git_prompt_status)
    else
      echo -n ${git_prompt}
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  local dir=''
  local _context="$(context)"
  [[ $POLYGLOT_DIR_CONTEXT_SHOW == true && -n "$_context" ]] && dir="${dir}${_context}:"

  if [[ $POLYGLOT_DIR_EXTENDED == 0 ]]; then
    #short directories
    dir="${dir}%1~"
  elif [[ $POLYGLOT_DIR_EXTENDED == 2 ]]; then
    #long directories
    dir="${dir}%0~"
  else
    #medium directories (default case)
    dir="${dir}%4(c:...:)%3c"
  fi

  prompt_segment $POLYGLOT_DIR_BG $POLYGLOT_DIR_FG $dir
}

# RUBY
# RVM: only shows RUBY info if on a gemset that is not the default one
# RBENV: shows current ruby version active in the shell; also with non-global gemsets if any is active
# CHRUBY: shows current ruby version active in the shell
prompt_ruby() {
  if command -v rvm-prompt > /dev/null 2>&1; then
    prompt_segment $POLYGLOT_RUBY_BG $POLYGLOT_RUBY_FG $POLYGLOT_RUBY_PREFIX" $(rvm-prompt i v g)"
  elif command -v chruby > /dev/null 2>&1; then
    prompt_segment $POLYGLOT_RUBY_BG $POLYGLOT_RUBY_FG $POLYGLOT_RUBY_PREFIX"  $(chruby | sed -n -e 's/ \* //p')"
  elif command -v rbenv > /dev/null 2>&1; then
    current_gemset() {
      echo "$(rbenv gemset active 2&>/dev/null | sed -e 's/ global$//')"
    }

    if [[ -n $(current_gemset) ]]; then
      prompt_segment $POLYGLOT_RUBY_BG $POLYGLOT_RUBY_FG $POLYGLOT_RUBY_PREFIX" $(rbenv version | sed -e 's/ (set.*$//')"@"$(current_gemset)"
    else
      prompt_segment $POLYGLOT_RUBY_BG $POLYGLOT_RUBY_FG $POLYGLOT_RUBY_PREFIX" $(rbenv version | sed -e 's/ (set.*$//')"
    fi
  fi
}

# Go
prompt_go() {
  setopt extended_glob
  go_files=( *.go(#qN) )
  if [[ ($#go_files -gt 0 || -f Gopkg.toml || -d Godeps || -f glide.yaml) ]]; then
    if command -v go > /dev/null 2>&1; then
      prompt_segment $POLYGLOT_GO_BG $POLYGLOT_GO_FG $POLYGLOT_GO_PREFIX" $(go version | grep --colour=never -oE '[[:digit:]].[[:digit:]]+')"
    fi
  fi
}

# Java
prompt_java() {
  setopt extended_glob
  java_files=( *.java(#qN) )
  if [[ ($#java_files -gt 0 || -f build.gradle || -f pom.xml) ]]; then
    if command -v java > /dev/null 2>&1; then
      prompt_segment $POLYGLOT_JAVA_BG $POLYGLOT_JAVA_FG $POLYGLOT_JAVA_PREFIX" $(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')"
    fi
  fi
}

# Rust
prompt_rust() {
  if [[ (-f Cargo.toml) ]]; then
    if command -v rustc > /dev/null 2>&1; then
      prompt_segment $POLYGLOT_RUST_BG $POLYGLOT_RUST_FG $POLYGLOT_RUST_PREFIX" $(rustc -V version | cut -d' ' -f2)"
    fi
  fi
}

# DOTNET
prompt_dotnet() {
  csharp_files=( *.cs(#qN) )
  dotnet_project_files=( *.csproj(#qN) )
  dotnet_solution_files=( *.sln(#qN) )
  if [[ ($#csharp_files -gt 0 || $#dotnet_project_files -gt 0 || $#dotnet_solution_files -gt 0) ]]; then
    if command -v dotnet > /dev/null 2>&1; then
      prompt_segment $POLYGLOT_DOTNET_BG $POLYGLOT_DOTNET_FG $POLYGLOT_DOTNET_PREFIX" $(dotnet --version | cut -d' ' -f2)"
    fi
  fi
}

# Python Virtualenv: current working virtualenv or default python
prompt_virtualenv() {
  python_files=( *.py(#qN) )
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment $POLYGLOT_VIRTUALENV_BG $POLYGLOT_VIRTUALENV_FG $POLYGLOT_VIRTUALENV_PREFIX" $(basename $virtualenv_path)"
  elif which pyenv &> /dev/null; then
    if [[ "$(pyenv version | sed -e 's/ (set.*$//' | tr '\n' ' ' | sed 's/.$//')" != "system" ]]; then
      prompt_segment $POLYGLOT_VIRTUALENV_BG $POLYGLOT_VIRTUALENV_FG $POLYGLOT_VIRTUALENV_PREFIX" $(pyenv version | sed -e 's/ (set.*$//' | tr '\n' ' ' | sed 's/.$//')"
    fi
  elif [[ ($#python_files -gt 0) ]]; then
    if command -v python > /dev/null 2>&1; then
      prompt_segment $POLYGLOT_VIRTUALENV_BG $POLYGLOT_VIRTUALENV_FG $POLYGLOT_VIRTUALENV_PREFIX" $(python --version | cut -d' ' -f2)"
    fi
  elif [[ -f Pipfile.lock ]]; then
    if command -v pipenv > /dev/null 2>&1; then
      prompt_segment $POLYGLOT_VIRTUALENV_BG $POLYGLOT_VIRTUALENV_FG $POLYGLOT_VIRTUALENV_PREFIX" $(pipenv run python --version | cut -d' ' -f2)"
    fi
  elif [[ -f poetry.lock ]]; then
    if command -v poetry > /dev/null 2>&1; then
      prompt_segment $POLYGLOT_VIRTUALENV_BG $POLYGLOT_VIRTUALENV_FG $POLYGLOT_VIRTUALENV_PREFIX" $(poetry run python --version | cut -d' ' -f2)"
    fi
  fi
}

# NVM: Node version manager
prompt_nvm() {
  javascript_files=( *.js(#qN) )
  node_package_files=( package*.json(#qN) )
  local nvm_prompt
  if [[ ($#javascript_files -gt 0 || $#node_package_files -gt 0) ]]; then
    if type nvm >/dev/null 2>&1; then
      nvm_prompt=$(nvm current 2>/dev/null)
      [[ "${nvm_prompt}x" == "x" || "${nvm_prompt}" == "system" ]] && return
    elif type node >/dev/null 2>&1; then
      nvm_prompt="$(node --version)"
    else
      return
    fi
    nvm_prompt=${nvm_prompt}
    prompt_segment $POLYGLOT_NVM_BG $POLYGLOT_NVM_FG $POLYGLOT_NVM_PREFIX$nvm_prompt
  fi
}

#AWS Profile
prompt_aws() {
  local spaces="  "

  if [[ -n "$AWS_PROFILE" ]]; then
    prompt_segment $POLYGLOT_AWS_BG $POLYGLOT_AWS_FG $POLYGLOT_AWS_PREFIX$spaces$AWS_PROFILE
  fi
}

prompt_time() {
  if [[ $POLYGLOT_TIME_12HR == true ]]; then
    prompt_segment $POLYGLOT_TIME_BG $POLYGLOT_TIME_FG %D{%r}
  else
    prompt_segment $POLYGLOT_TIME_BG $POLYGLOT_TIME_FG %D{%T}
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 && $POLYGLOT_STATUS_EXIT_SHOW != true ]] && symbols+="✘"
  [[ $RETVAL -ne 0 && $POLYGLOT_STATUS_EXIT_SHOW == true ]] && symbols+="✘ $RETVAL"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡%f"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="⚙"

  if [[ -n "$symbols" && $RETVAL -ne 0 ]]; then
    prompt_segment $POLYGLOT_STATUS_ERROR_BG $POLYGLOT_STATUS_FG "$symbols"
  elif [[ -n "$symbols" ]]; then
    prompt_segment $POLYGLOT_STATUS_BG $POLYGLOT_STATUS_FG "$symbols"
  fi

}

# Prompt Character
prompt_chars() {
  local bt_prompt_chars="${POLYGLOT_PROMPT_CHAR}"

  if [[ $POLYGLOT_PROMPT_ROOT == true ]]; then
    bt_prompt_chars="%(!.%F{red}# .%F{green}${bt_prompt_chars}%f)"
  fi

  if [[ $POLYGLOT_PROMPT_SEPARATE_LINE == false ]]; then
    bt_prompt_chars="${bt_prompt_chars}"
  fi

  echo -n "$bt_prompt_chars"

  if [[ -n $POLYGLOT_PROMPT_CHAR ]]; then
    echo -n " "
  fi
}

# Prompt Line Separator
prompt_line_sep() {
  if [[ $POLYGLOT_PROMPT_SEPARATE_LINE == true ]]; then
    # newline wont print without a non newline character, so add a zero-width space
    echo -e '\n%{\u200B%}'
  fi
}

# ------------------------------------------------------------------------------
# MAIN
# Entry point
# ------------------------------------------------------------------------------

build_prompt() {
  RETVAL=$?
  for segment in $POLYGLOT_PROMPT_ORDER
  do
    prompt_$segment
  done
  prompt_end
}

NEWLINE='
'
PROMPT=''
[[ $POLYGLOT_PROMPT_ADD_NEWLINE == true ]] && PROMPT="$PROMPT$NEWLINE"
PROMPT="$PROMPT"'%{%f%b%k%}$(build_prompt)'
[[ $POLYGLOT_PROMPT_SEPARATE_LINE == true ]] && PROMPT="$PROMPT$NEWLINE"
PROMPT="$PROMPT"'%{${fg_bold[default]}%}'
[[ $POLYGLOT_PROMPT_SEPARATE_LINE == false ]] && PROMPT="$PROMPT "
PROMPT="$PROMPT"'$(prompt_chars)%{$reset_color%}'
