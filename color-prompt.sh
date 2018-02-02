parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

C_WHITE='\[\e[1;37m\]'
C_LIGHTGRAY='\[\e[0;37m\]'
C_GRAY='\[\e[1;30m\]'
C_BLACK='\[\e[0;30m\]'
C_RED='\[\e[0;31m\]'
C_LIGHTRED='\[\e[1;31m\]'
C_GREEN='\[\e[0;32m\]'
C_LIGHTGREEN='\[\e[1;92m\]'
C_BROWN='\[\e[0;33m\]'
C_YELLOW='\[\e[1;33m\]'
C_BLUE='\[\e[0;34m\]'
C_LIGHTBLUE='\[\e[1;34m\]'
C_PURPLE='\[\e[0;35m\]'
C_PINK='\[\e[1;35m\]'
C_CYAN='\[\e[0;36m\]'
C_LIGHTCYAN='\[\e[1;36m\]'
C_DEFAULT='\[\e[0m\]'

GOOD_EMOJI_ARR=(💜 🤖 💋 👄 🧚‍♀️ 🧜‍♂️ 🧞‍♀️ 🙅‍♀️ 💅 👑 👓 🐶 🐱 🐭 🐹 🐰 🦊 🐻 🐼 🐨 🐯 🦁 🐮 🐷 🐽 🐸 🐵 🐔 🐧 🐦 🐤 🐣 🐥 🦆 🦉 🐴 🦄 🐝 🦋 🐌 🐚 🐞 🦎 🐍 🐙 🐠 🐳 🐬 🐋 🦓 🕊 🐇 🐿 🦔 🐉 🌿 ☘️ 🍀 🌹 🌺 🌸 🌼 🌈 ⭐️ 💧 ⚡️ ✨ 🌟 ⭐️ 🌊 🍏 🍎 🍐 🍊 🍋 🍌 🍉 🍑 🍒 🍈 🍓 🍇 🥝 🍅 🍆 🥑 🥦 🥒 🌶 🥖 🍞 🥐 🍠 🥔 🥕 🌽 🥨 🧀 🍕 🍟 🍔 🌭 🌮 🌯 🍣 🍦 🍰 🎂 🍭 🍪 🥟 🍩 🍿 🍫 🍬 🍯 ☕️ 🥤 🍸 🍷 🥂 🎼 🏆 🏍 🛵 ⚓️ ✈️ 🚀 ⛱ 🏔 ⛩ 💰 🕯 💸 💎 🔨 🔮 🛁 🎀 🎈 🎉 ❤️ 🧡 💛 💚 💙 💜 🖤 💖 💗 💕 ❣️ 💔 💟 ⛔️ 💯 ✅ 😀 😃 😄 😁 😆 😅 😂 🤣 😊 😇 😍 🙃 🤓 😎 🤩 🤗️ 😺 😸 😹 😻 😼 😽 🙀 😾 😿)
BAD_EMOJI_ARR=(😡 😢 😭 😖 😤 🤬 🤯 😳 😱 😨 😰 😥 😓 🤢 🤮 😈 👿 👹 👺 💩 👻 💀 ☠ ❌ 🗡 🔪 ⚔️)

# Choose a random emoji
GOOD_EMOJI='`echo ${GOOD_EMOJI_ARR[$RANDOM % 22]}`'
BAD_EMOJI='`echo ${BAD_EMOJI_ARR[$RANDOM % 22]}`'

function setsymbols() {
  local exit_status=$?
  local color_exit=
  local color_exit2=
  local color_exit3=
  local usym=
  local end_sym=\$
  local usegit=1
  local id=`/usr/bin/id -u`
  [[ $id == 0 ]] && end_sym=\#
  if [ $exit_status = 0 ]; then
    if [[ $id == 0 ]]; then
      color_exit="$C_LIGHTBLUE"; color_exit2="$C_BLUE"; color_exit3="$C_WHITE";exit_emoji="$GOOD_EMOJI";
    else
      color_exit="$C_LIGHTGREEN"; color_exit2="$C_GREEN"; color_exit3="$C_LIGHTBLUE";exit_emoji="$GOOD_EMOJI";
    fi
    usym=":"
  else
    if [[ $id == 0 ]]; then
      color_exit="$C_LIGHTRED"; color_exit2="$C_RED"; color_exit3="$C_BROWN"; exit_emoji="$BAD_EMOJI";
    else
      color_exit="$C_LIGHTRED"; color_exit2="$C_RED"; color_exit3="$C_LIGHTCYAN";exit_emoji="$BAD_EMOJI";
    fi
    usym="!"
  fi
  PS1="${VIRTUAL_ENV:+$C_PURPLE($(basename $VIRTUAL_ENV)) }${C_DEFAULT} ${exit_emoji} \
${color_exit}\u\
${color_git}${usym}\
${color_exit3}\w${color_exit2}${color_job}\
${C_PINK}$(parse_git_branch)\
${end_sym}\
${C_DEFAULT} "
}

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND=setsymbols
else
    PS1='\u@${HOSTNAME}:\w\$ '
fi
unset color_prompt force_color_prompt

