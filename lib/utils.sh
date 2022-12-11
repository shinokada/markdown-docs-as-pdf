fn_move_files(){
  bannerColor "Removing old files and dirs from ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove old dirs
  rm -rf ${WEBAPP}/${NAME}/${LANG}
  # create a new dir
  mkdir -p ${WEBAPP}/${NAME}/${LANG} 
  bannerColor "Successfully removed old dir from." "green" "*"

  # remove non-html files 
  bannerColor "Removing all non-HTML files from ${WORKSPACE} ..." "blue" "*"
  find ${WORKSPACE} -type f -not -name '*.html' -delete
  bannerColor "Successfully removed non-HTML files." "green" "*"

  bannerColor "Minifying HTML files and outputting to ${WEBAPP}/${NAME}/${LANG}." "blue" "*"
  # minify to ${WEBAPP}/${NAME}/${LANG}
  html-minifier  --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --minify-css true --minify-js true --input-dir ${WORKSPACE} --output-dir ${WEBAPP}/${NAME}/${LANG}
  bannerColor "Successfully minified and moved." "green" "*"
  # mkdir -p ${WEBAPP}/${NAME}/${LANG} && cp -r ${WORKSPACE}/*.html ${WEBAPP}/${NAME}/${LANG}
}

repeat(){
  END=$2
  for i in $(eval echo "{1..$END}")
  do
    echo -n "$1"
  done
}

append_mixed_footnote(){
  file=$1
  #  e.g. "/Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf/.vivliostyle/nest/en/content/application-context.md", 9 slashes
  # "/Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf/.vivliostyle/nest/en/content/cli/libraries.md", 10 slashes
  # "/Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf/.vivliostyle/sveltekit/en/docs/10-getting-started/10-introduction.md",
  # "/Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf/.vivliostyle/sveltekit/en/faq/80-integrations.md",
  # then it should be ./index.html#toc
  # you can check it the number of slashes
  # if a $file has no slashes after removing WORKSPACE then it should be ./index.html#toc
  # remove WORKSPACE from $file
  dir=${file/"$INDEXDIR"/}
  # file_without_workspace=$(sed "s|${WORKSPACE}||" ${file})
  # printf $file_without_workspace
  # find the number of slashes
  s=${dir//[^\/]}; 
  num=${#s}
  if [ $num -gt 1 ];then
    let repeat_num=$num-1
    path_str=$(repeat '../' $repeat_num)
    echo "<span style='float: footnote;'><a href=\"${path_str}index.html#toc\">Go to TOC</a></span>" >> "$file"
    # echo '<span style="float: footnote;"><a href="../index.html#toc">Go to TOC</a></span>' >> "$file"
  # elif [ $num = 10 ]; then
  #   echo '<span style="float: footnote;"><a href="../../index.html#toc">Go to TOC</a></span>' >> "$file"
  else
    echo '<span style="float: footnote;"><a href="./index.html#toc">Go to TOC</a></span>' >> "$file"
  fi
  
}

fix_link(){
  file=$1
  # ](/docs/ to ](./docs/
  sed -i 's|](/docs/|](./|g' $file
}

md_to_html(){
  file=$1
  # change [here](./style-guide.md) to [here](./style-guide.html)
  sed -i 's|.md)|.html)|' $file
}

# get_line_docs(){
#   line=$1
  # find line e.g. [project config](/docs/configuration), pattern=](/docs/
# }

get_theme_link(){
  if [ $WEB ]; then
      THEMELINK="/docs/themes/packages/prism-coy-theme/theme_common.css"
    else      
      THEMELINK="${script_dir}/themes/packages/prism-coy-theme/theme_common.css"
    fi
}

get_cover_image(){
  case $1 in
    bulletproof-react)
      IMGNAME="react.svg";;
    nestjs)
      IMGNAME="nestjs.svg";;
    nuxt)
      IMGNAME="nuxt.svg";;
    pnpm)
      IMGNAME="pnpm.svg";;
    react)
      IMGNAME="react.svg";;
    shellspec)
      IMGNAME="terminal.svg";;
    slidev)
      IMGNAME="slidev.png";;
    svelte)
      IMGNAME="svelte.svg";;
    sveltekit)
      IMGNAME="sveltekit.webp";;
    tauri)
      IMGNAME="tauri.svg";;
    typescript)
      IMGNAME="typescript.svg";;
    vite)
      IMGNAME="vite.svg";;
    vitepress)
      IMGNAME="vitepress.png";;
    vitest)
      IMGNAME="vitest.svg";;
    vue)
      IMGNAME="vue.svg";;
    zod)
      IMGNAME="zod.svg";;
    *)
      IMGNAME="pdf.svg"
    esac
    if [ $WEB ]; then
      IMGNAME="/docs/images/${IMGNAME}"
    else      
      IMGNAME="${script_dir}/images/${IMGNAME}"
    fi
}

remove_slash_docs(){
  file=$1
  # ](/docs/ to ](
  sed -i 's|](/docs/|](|g' $file
}

replace_three_dots(){
   # 1. change :::note to <blockquote>, 2. add line break after Note or note, info
  # 3. change ::: to </blockquote>, 4. remove "
  sed -i -e 's/\:\:\:note/\<blockquote\>/' \
  -e 's/\:\:\:tip/\<blockquote\>/' \
  -e 's/\:\:\:info/\<blockquote\>/' \
  -e 's/\:\:\:warning/\<blockquote\>/' \
  -e '/Note/G' \
  -e '/note/G' \
  -e '/info/G' \
  -e 's/"//g' \
  -e 's/\:\:\:/\<\/blockquote\>/' "$file"
}

get_title(){
  file=$1
  # save title
  # title=${file#*title: }
  # Remove between ---
  sed -i 's/^--- .* ^---//' $file
}

fix_link_html(){
  file=$1
  # change from ](./api-javascript#vitedevserver) to ](./api-javascript.html#vitedevserver)
  sed -i 's/](\(\.\/.*\)#/](\1.html#/g' $file
}

fix_link_without_dot_html(){
  # links need to be relative 
  file=$1
  # change from  [global configuration](/config/#globals) to  [global configuration](../config/index.html#globals)
  # Won't work since config dir has only index and guide dir has many files
  # sed -i 's/](\/\(.*\)\/#/](\1.html#/g' $file 
  sed -i 's_\(\[[^]]*]\)(/\([^#]*\)/\(#[^)]*\))_\1(..\/\2.html\3)_g' $file
}

clean_word(){
  # without -, /, _ and first letter uppercase
  WORD=$1
  # replace all - to spaces
  # two /s instead of one / for global search
  WORD="${WORD//-/ /}"
  # remove all / 
  # two /s instead of one / for global search
  WORD="${WORD//\/}"
  # replaceall  _ to space
  WORD="${WORD//_/ /}"
  # remove all "
  # sed -i 's/"//g' $WORD
  # Uppercase the first characters
  WORD="${WORD^}"
  echo "$WORD"
}

get_category_title(){
  line=$1
  name=$2 # sveltekit | nuxt
  # method 1
  # get the last two items, 10-getting-started and 10-introduction.md

  IFS='/' read -ra line_array <<< "$line"
  title="${line_array[-1]}" # 10-introduction.md
  category="${line_array[-2]}" # 10-getting-started

  # method 2 is for more than 2 dir deep
  # "/Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf/.vivliostyle/tauri/en/api/js/app.md",
  # remove ${WORKSPACE} to api/js/app.md",
  
  # sed -i 's/${WORKSPACE}//' $line
  # category api/js, title app.md",
  # title=$(basename "$line")
  # filedirname=$(dirname "$line")
  # category=$(basename $filedirname)
  # category=$(dirname "$line")
  # printf "$title\n"
  # printf "$category"

  
  if [ $NAME = 'sveltekit' ];then
    # remove the first 3 characters "00 "
    title=${title:3}
    category=${category:3}
  elif [ $NAME = 'nuxt' ];then
    # remove the first 2 characters "1."
    # title=${title:2}
    # remove all before a period from "1.", "10."
    title=${title#*.}
    category=${category#*.}
    # category=${category:2}
  fi

  # remove the last 5 characters, .md
  title=${title::-5}
  # replace - with space, first letter uppercase
  # bannerColor "Replacing - with space, first letter uppercase ..." "cyan" "*"
  title=$(clean_word $title)
  # printf $title
  # bannerColor "Replacing - with space, first letter uppercase ..." "magenta" "*"
  category=$(clean_word $category)
  # printf $category
  # combine to to create TITLE
  TITLE="${category} - ${title}"
  # printf "Title is: $TITLE"
  echo "$TITLE"
}

get_index_dir(){
  # this will set where you want to keep index and colophon.me
  NAME=$1
  LANG=$2
  case $NAME in
    bulletproof-react)
      INDEXDIR="${WORKSPACE}";;
    express)
      INDEXDIR="${WORKSPACE}/${LANG}";;
    nestjs)
      INDEXDIR="${WORKSPACE}/content";;
    nuxt)
      INDEXDIR="${WORKSPACE}/content/${LANG}/docs";;
    pnpm)
      INDEXDIR="${WORKSPACE}";;
    react)
      INDEXDIR="${WORKSPACE}/docs";;
    shellspec)
      INDEXDIR="${WORKSPACE}";;
    slidev)
      INDEXDIR="${WORKSPACE}";;
    svelte)
      INDEXDIR="${WORKSPACE}";;
    sveltekit)
      INDEXDIR="${WORKSPACE}";;
    tauri)
      INDEXDIR="${WORKSPACE}";;
    vite)
      INDEXDIR="${WORKSPACE}/guide";;
    vitepress)
      INDEXDIR="${WORKSPACE}";;
    vitest)
      INDEXDIR="${WORKSPACE}";;
    vue)
      INDEXDIR="${WORKSPACE}";;
    *)
      INDEXDIR="${WORKSPACE}"
    esac
}

get_github_url(){
  NAME=$1
  LANG=$2
  
  if [ $NAME = 'bulletproof-react' ];then
    GITHUBURL="alan2207/bulletproof-react/docs"
  elif [ $NAME = 'deta' ];then
    GITHUBURL="deta/docs/docs"
  elif [ $NAME = 'express' ];then
    GITHUBURL="expressjs/expressjs.com"
  elif [ $NAME = 'nestjs' ];then
    GITHUBURL="nestjs/docs.nestjs.com"
  elif [ $NAME = 'next' ];then
    GITHUBURL="vercel/next.js/docs"
  elif [ $NAME = 'nuxt' ];then
    GITHUBURL="nuxt/nuxtjs.org"
  elif [ $NAME = 'pnpm' ];then
    GITHUBURL="pnpm/pnpm.github.io/docs"
  elif [ $NAME = 'react' ];then
    if [ $LANG = 'en' ];then
      GITHUBURL="reactjs/reactjs.org/content"
    else
      GITHUBURL="reactjs/${LANG}.reactjs.org/content"
    fi
  elif [ $NAME = 'shellspec' ];then
    GITHUBURL="shellspec/shellspec/docs"
  elif [ $NAME = 'slidev' ];then
    case $2 in
    en)
      GITHUBURL="slidevjs/docs";;
    br)
      GITHUBURL="slidevjs/docs-br";;
    cn)
      GITHUBURL="slidevjs/docs-cn";;
    de)
      GITHUBURL="slidevjs/docs-de";;
    el)
      GITHUBURL="slidevjs/docs-el";;
    es)
      GITHUBURL="slidevjs/docs-es";;
    fr)
      GITHUBURL="slidevjs/docs-fr";;
    ja)
      GITHUBURL="slidevjs/docs-ja";;
    ru)
      GITHUBURL="slidevjs/docs-ru";;
    vn)
      GITHUBURL="slidevjs/docs-vn";;
    *)
      echo "URL does not exist."
      exit 1 
    esac
  elif [ $NAME = 'svelte' ];then
    case $2 in
    en)
      GITHUBURL="sveltejs/svelte/site/content/docs";;
    ja)
      GITHUBURL="svelte-jp/svelte-site-jp/site/content/docs";;
    *)
      echo "URL does not exist."
      exit 1 
    esac
  elif [ $NAME = 'sveltekit' ];then
    case $2 in
    en)
      GITHUBURL="sveltejs/kit/documentation";;
    ja)
      GITHUBURL="svelte-jp/kit/documentation";;
    *)
      echo "URL does not exist."
      exit 1 
    esac
  elif [ $NAME = 'tauri' ];then
    GITHUBURL="tauri-apps/tauri-docs/docs"
  elif [ $NAME = 'typescript' ];then
    GITHUBURL="microsoft/TypeScript-Website/packages/documentation/copy/en"
  elif [ $NAME = 'vite' ];then
    GITHUBURL="vitejs/vite/docs"
  elif [ $NAME = 'vitepress' ];then
    GITHUBURL="vuejs/vitepress/docs/guide"
  elif [ $NAME = 'vitest' ];then
  case $2 in
    en)
      GITHUBURL="vitest-dev/vitest/docs";;
    cn)
      GITHUBURL="vitest-dev/docs-cn";;
    *)
      echo "URL does not exist."
      exit 1 
    esac
  elif [ $NAME = 'vue' ];then
    GITHUBURL="vuejs/docs/src/guide"
  elif [ $NAME = 'zod' ];then
    GITHUBURL="colinhacks/zod"
  else
    echo "URL does not exist."
    exit 1
  fi
}

get_language(){
  case $1 in
  br)
    LANGUAGE="Português-BR";;
  cn)
    LANGUAGE="简体中文";;
  de)
    LANGUAGE="Deutsch";;
  el)
    LANGUAGE="Ελληνικά";; # Greek
  en)
    LANGUAGE="English";;
  es) 
    LANGUAGE="Español";;
  fr)
    LANGUAGE="Français";;
  he)
    LANGUAGE="עברית";;
  it)
    LANGUAGE="Italiano";;
  ja)
    LANGUAGE="日本語";;
  ko)
    LANGUAGE="한국어";;
  pl)
    LANGUAGE="Polski";;
  pt)
    LANGUAGE="Português";;
  pt-br)
    LANGUAGE="Português(BR)";;
  ru)
    LANGUAGE="Русский";;
  sk)
    LANGUAGE="slovenčina";;
  th)
    LANGUAGE="ภาษาไทย";;
  tr)
    LANGUAGE="Türkçe";;
  vn)
    LANGUAGE="Việt Nam";;
  zh-hans)
    LANGUAGE="中文";;
  zh-hant)
    LANGUAGE="漢語";;
  zh-tw)
    LANGUAGE="國語";;
  *)
    LANGUAGE="English";;
  esac
}


remove_between_backtick(){
  sed -i 's/---.*---//' "${file}"
}




check_cmd() {
  if [ ! "$(command -v "$1")" ]; then
    app=$1
    redprint "It seems like you don't have ${app}."
    redprint "Please install ${app}."
    exit 1
  fi
}

# bash version check
check_bash() {
  # If you are using Bash, check Bash version
  if ((BASH_VERSINFO[0] < $1)); then
    printf '%s\n' "Error: This requires Bash v${1} or higher. You have version $BASH_VERSION." 1>&2
    exit 2
  fi
}

### Colors ##
ESC=$(printf '\033')
RESET="${ESC}[0m"
BLACK="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
DEFAULT="${ESC}[39m"

### Color Functions ##

blackprint() {
    printf "${BLACK}%s${RESET}\n" "$1"
}

blueprint() {
    printf "${BLUE}%s${RESET}\n" "$1"
}

cyanprint() {
    printf "${CYAN}%s${RESET}\n" "$1"
}

defaultprint() {
    printf "${DEFAULT}%s${RESET}\n" "$1"
}

greenprint() {
    printf "${GREEN}%s${RESET}\n" "$1"
}

magentaprint() {
    printf "${MAGENTA}%s${RESET}\n" "$1"
}

redprint() {
    printf "${RED}%s${RESET}\n" "$1"
}

whiteprint() {
    printf "${WHITE}%s${RESET}\n" "$1"
}

yellowprint() {
    printf "${YELLOW}%s${RESET}\n" "$1"
}

# Text attribute
BOLD="${ESC}[1m"
FAINT="${ESC}[2m"
ITALIC="${ESC}[3m"
UNDERLINE="${ESC}[4m"
SLOWBLINK="${ESC}[5m"
SWAP="${ESC}[7m"
STRIKE="${ESC}[9m"

boldprint() {
    printf "${BOLD}%s${RESET}\n" "$1"
}

faintprint() {
    printf "${FAINT}%s${RESET}\n" "$1"
}

italicprint() {
    printf "${ITALIC}%s${RESET}\n" "$1"
}

underlineprint() {
    printf "${UNDERLINE}%s${RESET}\n" "$1"
}

slowblinkprint() {
    printf "${SLOWBLINK}%s${RESET}\n" "$1"
}

swapprint() {
    printf "${SWAP}%s${RESET}\n" "$1"
}

strikeprint() {
    printf "${STRIKE}%s${RESET}\n" "$1"
}


# lib/banners
# Usage: bannerSimple "my title" "*"
function bannerSimple() {
    msg="${2} ${1} ${2}"
    edge=$(echo "${msg}" | sed "s/./"${2}"/g")
    echo "${edge}"
    echo "$(tput bold)${msg}$(tput sgr0)"
    echo "${edge}"
    echo
}

# Usage: bannerColor "my title" "red" "*"
function bannerColor() {
    case ${2} in
    black)
        color=0
        ;;
    red)
        color=1
        ;;
    green)
        color=2
        ;;
    yellow)
        color=3
        ;;
    blue)
        color=4
        ;;
    magenta)
        color=5
        ;;
    cyan)
        color=6
        ;;
    white)
        color=7
        ;;
    *)
        echo "color is not set"
        exit 1
        ;;
    esac

    msg="${3} ${1} ${3}"
    edge=$(echo "${msg}" | sed "s/./${3}/g")
    tput setaf ${color}
    tput bold
    echo "${edge}"
    echo "${msg}"
    echo "${edge}"
    tput sgr 0
    echo
}