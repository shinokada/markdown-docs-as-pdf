fn_create() {
  # check if NAME is given
  if [ -z $NAME ]; then
    echo "You must specify the name -n."
    exit 1
  fi

  WORKSPACE="${script_dir}/${VIVLIOSTYLE}/${NAME}/${LANG}"
  DOCDIR="${script_dir}/${DOCUMENTS}/${NAME}/${LANG}"
  FILENAME1="filenames1"
  
  # get $LANGUAGE
  get_language $LANG # this returns LANGUAGE
  
  # when user press ctrl-c clean the pdf
  cleanup_doc () {
    rm "${DOCDIR}/${NAME}-${LANG}.pdf"
  }
  trap cleanup_doc SIGINT

  # cleanup filename1
  if [ -f "${script_dir}/${FILENAME1}" ]; then
    rm "${script_dir}/${FILENAME1}"
  fi

  # cleanup the previous doc
  # if [[ !$WEB && -f "${DOCDIR}/${NAME}-${LANG}.pdf" ]]; then
  #   bannerColor "Removing the previous ${NAME}-${LANG} ..." "blue" "*"
  #   cleanup_doc
  # fi

  # create filename1
  touch "${script_dir}/${FILENAME1}" 

  # if there is workspace directory, remove it
  if [ -d "${WORKSPACE}" ]; then
    bannerColor "Removing and creating the previous ${WORKSPACE} dir." "blue" "*"
    rm -rf "${WORKSPACE:?Does not exist}/"
  fi

  
  # if it is not WEB and there is a "${script_dir}/${DOCUMENTS}/${NAME}/${LANG}" dir
  # remove it and create a new
  if [[ $WEB -lt 1 && -d "${script_dir}/${DOCUMENTS}/${NAME}/${LANG}" ]]; then
    bannerColor "Removing ${script_dir}/${DOCUMENTS}/${NAME}/${LANG}." "blue" "*"
    rm -rf "${script_dir}/${DOCUMENTS}/${NAME}/${LANG}"
    mkdir -p "${script_dir}/${DOCUMENTS}/${NAME}/${LANG}"
  fi
  
  bannerColor "Creating ${WORKSPACE}." "green" "*"
  # create a new dir
  mkdir -p "${WORKSPACE}"
  cd "${WORKSPACE}" || exit 1

  # clone the repo
  bannerColor "Cloning ..." "green" "*"
  if [ $URL ]; then
    GITHUBURL="$URL"
  else
    # get github url from $NAME and $LANG
    get_github_url $NAME $LANG
  fi
  npx tiged "${GITHUBURL}" >/dev/null 2>&1 || {
      echo "not able to clone"
      exit 1
  }
  
  # Get INDEXDIR
  get_index_dir $NAME $LANG
  get_theme_link 

  # start creating vivliostyle.config.js
  titlename=${NAME^^}
  cat << EOF > "${script_dir}/vivliostyle.config.js"
module.exports = {
  author: "${titlename}",
  theme: "${THEMELINK}",
  size: "${PAPERSIZE}",
  language: "${LANG}",
  entry: [
    "${INDEXDIR}/index.md",
EOF

  # For vivliostyle.config.js
  # Creating FILENAME1 to append it to vivliostyle.config.js later
  # each framework docs has different structure and format
  # nuxtjs
  bannerColor "Updating markdown files." "green" "*"
  if [ $NAME = 'nuxt' ]; then # nuxt has sub dirs
    bannerColor "Updating nuxt ..." "yellow" "*"
    for file in $(find "${WORKSPACE}/content/${LANG}/docs" -name '*.md');
    do
      if [[ $file != *"index.md" ]]; then
        remove_between_backtick "$file"
        clean_nuxt "$file"
        fix_link "$file"
        append_mixed_footnote "$file" 
        if [ $WEB ]; then
        # for web change /img/docs/ to ../docs
          sed -i 's|/img/docs|../docs|' "${file}"
        else
          # change /img/docs/ to ../../../static/img/docs
          sed -i 's|/img/docs|../../../../static/img/docs|' "${file}"
        fi
        echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
      fi
    done;
  elif [ $NAME = 'bulletproof-react' ]; then # bulletproof-react
    bannerColor "Updating bulletproof-react ..." "yellow" "*"
    . "${script_dir}/lib/utils_bulletproof.sh"
    for file in "${WORKSPACE}"/*.md;
    do
      bannerColor "cleaning ..." "yellow" "*"
      clean_bulletproof "$file"
      bannerColor "appending ..." "yellow" "*"
      append_mixed_footnote "$file"
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done
  elif [ $NAME = 'deta' ]; then
    bannerColor "Updating deta ..." "yellow" "*"
    . "${script_dir}/lib/utils_deta.sh"
    for file in $(find ${WORKSPACE} -name '*.md');
    do
      get_title "$file"
      clean_deta "$file"
      replace_three_dots "$file"
      append_mixed_footnote "$file"
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done
  elif [ $NAME = 'express' ]; then
    bannerColor "Updating express ..." "yellow" "*"
    . "${script_dir}/lib/utils_express.sh"
    for file in $(find "${WORKSPACE}/${LANG}" -name '*.md');
    do
      # get_title "$file"
      clean_express "$file"
      # replace_three_dots "$file"
      append_mixed_footnote "$file"
      # middleware pages has no content only links
      if [[ ! $file =~ "/middleware/" && ! $file =~ "/3x/" && ! $file =~ "/4x/" && ! $file =~ "/5x/" && ! $file =~ "/index.md" ]];then
        echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
      fi
    done
  elif [ $NAME = 'nestjs' ]; then
    bannerColor "Updating nestjs ..." "yellow" "*"
    . "${script_dir}/lib/utils_nestjs.sh"
    for file in $(find "${WORKSPACE}/content" -name '*.md');
    do
      # fix_pnpm_link "$file"
      # get_pnpm_title "$file"
      clean_nestjs "$file"
      append_mixed_footnote "$file"
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'pnpm' ]; then
    bannerColor "Updating pnpm ..." "yellow" "*"
    for file in $(find ${WORKSPACE} -name '*.md');
    do
      fix_pnpm_link "$file"
      get_pnpm_title "$file"
      replace_three_dots "$file"
      append_mixed_footnote "$file" 1
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'react' ]; then # for react no subdir
    bannerColor "Updating react ..." "yellow" "*"
    # echo "it's react"
    # cd ${WORKSPACE}/docs
    # echo $(PWD)
    # for file in "${WORKSPACE}"/*.md;
    # change root index to name.md 
    mv "${WORKSPACE}/index.md" "${WORKSPACE}/react-index.md" 
    for file in $(find ${WORKSPACE} -name '*.md');
    do
      get_react_title "$file"
      fix_link "$file"
      append_mixed_footnote "$file" 1 # docs/*.md
      if [ $WEB ]; then
        # for web change /img/docs/ to ../docs
        sed -i 's|../images/docs|./docs|' "${file}"
      fi
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'slidev' ]; then
    bannerColor "Updating slidev ..." "yellow" "*"
    # change root index to name.md 
    # mv "${WORKSPACE}/index.md" "${WORKSPACE}/slidev-index.md" 
    for file in $(find "${WORKSPACE}" -name '*.md');
    do
      if [[ $file != *"vitepress"* ]]; then
        # remove_between_backtick "$file"
        # clean_nuxt "$file"
        # fix_link "$file"
        # change /img/docs/ to ../../../static/img/docs
        # sed -i 's|/img/docs|../../../../static/img/docs|' "${file}"
        if [ $file != "${WORKSPACE}/index.md" ];then
        clean_slidev_internal_link $file
        append_mixed_footnote "$file" 1
        if [ $WEB ]; then
          # for web change /img/docs/ to ../docs
          sed -i 's|../public/screenshots|../public|' "${file}"
        fi
        echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
        fi
      fi
    done;
  elif [ $NAME = 'svelte' ]; then # for svelte no sub dirs
    bannerColor "Updating svelte ..." "yellow" "*"
    for file in $(find ${WORKSPACE} -name '*.md');
    do
      get_svelte_title "$file"
      clean_svelte "$file" 
      append_mixed_footnote "$file"
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'sveltekit' ]; then  # for sveltekit has sub dirs
    bannerColor "Updating sveltekit ..." "yellow" "*"
    # sveltekit has sub-directories, use find command
    for file in $(find ${WORKSPACE} -name '*.md');
    do
      get_svelte_title "$file"
      fix_sveltekit_link "$file" 
      append_mixed_footnote "$file"  #/docs/10-getting/*.md
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'tauri' ]; then # tauri has sub dirs
    bannerColor "Updating tauri ..." "yellow" "*"
    . "${script_dir}/lib/utils_tauri.sh"
    for file in $(find "${WORKSPACE}/" -name '*.md');
    do
      replace_three_dots "$file"
      clean_vite "$file"
      md_to_html "$file"
      append_mixed_footnote "$file" 2
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'typescript' ]; then
    bannerColor "Updating typescript ..." "yellow" "*"
    . "${script_dir}/lib/utils_typescript.sh"
    bannerColor "Replacing spaces with underbar for file names." "green" "*"
    cd ${WORKSPACE} && find . -type d -exec rename 's/ /_/g' {} + >/dev/null 2>&1 &&    find . -type f -name '*.md' -exec rename 's/ /_/g' {} + >/dev/null 2>&1

    for file in $(find "${WORKSPACE}/" -name '*.md');
    do
      # get_svelte_title "$file"
      # clean_svelte "$file" 
      append_mixed_footnote "$file" 2
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'vite' ]; then # vite
    bannerColor "Updating vite ..." "yellow" "*"
    for file in "${WORKSPACE}"/guide/*.md;
    do
      # bannerColor "Cleaning files ..." "blue" "*"
      clean_vite "$file"
      # bannerColor "Appending footnote ..." "blue" "*"
      append_mixed_footnote "$file" 1
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
    # change "${WORKSPACE}/guide/index.md", to "${WORKSPACE}/guide/getting-started.md" since it is the same as vivliostyle index.md
    mv ${WORKSPACE}/guide/index.md ${WORKSPACE}/guide/getting-started.md
    sed -i 's/index.md/getting-started.md/' "${script_dir}/${FILENAME1}"
  elif [ $NAME = 'vitepress' ]; then # vitepress
    bannerColor "Updating vitepress ..." "yellow" "*"
    . "${script_dir}/lib/utils_vitepress.sh"
    for file in "${WORKSPACE}"/*.md;
    do
      clean_vitepress "$file" >/dev/null 2>&1
      append_mixed_footnote "$file"
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'vitest' ]; then # vitest has sub dirs
    bannerColor "Updating vitest ..." "yellow" "*"
    . "${script_dir}/lib/utils_vitest.sh"
    for file in $(find "${WORKSPACE}/" -name '*.md');
    do
      if [[ $file != "${WORKSPACE}/index.md" ]]; then
        clean_vitest "$file"
        append_mixed_footnote "$file" 1
        echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
      fi
    done;
  elif [ $NAME = 'vue' ]; then
    bannerColor "Updating vue ..." "yellow" "*"
    . "${script_dir}/lib/utils_vue.sh"
    for file in $(find ${WORKSPACE} -name '*.md');
    do
      append_mixed_footnote "$file" 2
      echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
    done;
  elif [ $NAME = 'zod' ]; then
    bannerColor "Updating zod ..." "yellow" "*"
    # append_mixed_footnote "$file" 
    echo "\"${WORKSPACE}/README.md\"," >> "${script_dir}/${FILENAME1}"
  else
    for file in $(find "${WORKSPACE}" -name '*.md');
    do
      if [[ $file = *"index.md" ]]; then
        append_mixed_footnote "$file" 1
        mv "${WORKSPACE}/index.md" "${WORKSPACE}/getting-started.md" 
        # rm "${WORKSPACE}/index.md"
        echo "\"${WORKSPACE}/getting-started.md\"," >> "${script_dir}/${FILENAME1}"
      else
        append_mixed_footnote "$file"
        echo "\"${file}\"," >> "${script_dir}/${FILENAME1}"
      fi
    done;
  fi

  bannerColor "Sorting files and Updating vivliostyle.config.js files ..." "blue" "*"
  # todo: like nestjs, when there are md files and dirs/file.md, you need to sort by the last two file string rather than file name.
  sort -u "${script_dir}/${FILENAME1}" >> "${script_dir}/vivliostyle.config.js"

  # create a colophon.md
  cat << EOF > "${INDEXDIR}/colophon.md"
<section id="colophon" role="doc-colophon">

## Colophon

This book is created by using the following sources:

- ${NAME^} - ${LANGUAGE}
- GitHub source: ${GITHUBURL}
- Created: $(date %F)
- Bash v5.2.2
- Vivliostyle, https://vivliostyle.org/
- By: @shinokada
- Viewer: https://read-html-download-pdf.vercel.app/
- GitHub repo: https://github.com/shinokada/markdown-docs-as-pdf
- Viewer repo: https://github.com/shinokada/read-html-download-pdf

</section>
EOF

  # Add colophon to vivliostyle.config.js
  echo "\"${INDEXDIR}/colophon.md\"],title: \"${NAME}\",};" >> "${script_dir}/vivliostyle.config.js"
  
  # Index page using index.md
  # add FILENAME and html to ${WORKSPACE}/index.md
  bannerColor "Creating index.md for TOC ..." "blue" "*"
  # get IMGNAME from get_cover_image function
  get_cover_image ${NAME}

  cat << EOF > "${INDEXDIR}/index.md"
# ${titlename} Docs - ${LANGUAGE}

<img src="${IMGNAME}" style="display: flex;
justify-content: center; padding-top: 50px; max-width:250px;" />

<nav id="toc" role="doc-toc">

## Table of contents

EOF
  
  bannerColor "Adding titles and links to .vivliostyle/${INDEXDIR}/index.md for TOC ..." "blue" "*"
  LINES=$(sort -n "${script_dir}/${FILENAME1}" | cat)
  for line in $LINES
  do
    # remove the first quotes "
    temp="${line#\"}"
    # remove the last 5 characters, .md",
    HTML=${temp::-5}
    # replace $WORKSPACE with .
    HTML=${HTML/${INDEXDIR}/.}

    TITLEBASENAME=$(basename $line)

    if [ $NAME = 'sveltekit' ]; then
      # for sveltekit
      # $line will be "/Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf/.vivliostyle/sveltekit/en/docs/10-getting-started/10-introduction.md",
      # For links, it should be changed to ./docs/10-getting-started/10-introduction.html
      # or to ./faq/00-other-resources.html
      # For title: Getting started - Introduction
      # Getting started - Creating a project, etc
      # bannerColor "Creating index.md for SvelteKit ..." "blue" "*"
      # title for sveltekit
      # sveltekit has docs and faq dir
      if [[ $line =~ "/docs/" ]]; then
        TITLE=$(get_category_title "$line" $NAME)
      else
        # faq dir
        # remove the last 5 characters, .md",
        TITLE=${TITLEBASENAME::-5}
        # remove first 3 from 00 other resouces
        TITLE=${TITLE:3}
        TITLE=$(clean_word $TITLE)
        category="FAQ"
        TITLE="${category} - ${TITLE}"
      fi
    elif [ $NAME = 'svelte' ];then
      # remove the last 5 characters, .md",
      TITLE=${TITLEBASENAME::-5}
      # remove the first 3 characters "00 "
      TITLE=${TITLE:3}
      # this will return TITLE without -, /, and first letter uppercase
      TITLE=$(clean_word $TITLE)
    elif [ $NAME = 'express' ];then
      TITLE=$(get_category_title "$line" $NAME)
    elif [ $NAME = 'nestjs' ];then
      TITLE=$(get_category_title "$line" $NAME)
    elif [ $NAME = 'nuxt' ];then
      TITLE=$(get_category_title "$line" $NAME)
      # same as sveltekit except docs and faq dir
      # remove the last 5 characters, .md",
      # TITLE=${TITLEBASENAME::-5}
      # # remove 1., 2. etc. remove all before and including .
      # TITLE=${TITLE#*.}
      # # this will return TITLE without -, /, and first letter uppercase
      # TITLE=$(clean_word $TITLE)
      # todo
      # $line is "/Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf/.vivliostyle/nuxt/en/content/en/docs/1.get-started/1.installtion.md",
      # change this to Get started - Installation 
      # similar to SvelteKit
    elif [ $NAME = 'pnpm' ];then
      if [[ $line =~ "/cli/" ]]; then
        TITLE=$(get_category_title "$line" $NAME)
      else
        # faq dir
        # remove the last 5 characters, .md",
        TITLE=${TITLEBASENAME::-5}
        # remove first 3 from 00 other resouces
        # TITLE=${TITLE:3}
        TITLE=$(clean_word $TITLE)
        TITLE="${TITLE}"
      fi
    elif [ $NAME = 'slidev' ];then
      TITLE=$(get_category_title "$line" $NAME)
    elif [ $NAME = 'tauri' ];then
      # already sourced utils_tauri.sh before
    
      TITLE=$(get_tauri_category_title "$line")
    elif [ $NAME = 'typescript' ];then    
      TITLE=$(get_typescript_category_title "$line")
      TITLE="${TITLE//\/}"
    elif [ $NAME = 'vitest' ];then
      TITLE=$(get_category_title "$line" $NAME)
    else
      # like react doc, there are only files not dir
      # this will return TITLE without -, /, and first letter uppercase
      # remove the last 5 characters, .md",
      TITLE=${TITLEBASENAME::-5}
      TITLE=$(clean_word $TITLE)
    fi

    # for svelte that has html in the same dir
    echo "- [$TITLE](${HTML}.html)" >> "${INDEXDIR}/index.md"
  done

  # add the finishing tag to index.md
  cat << EOF >> "${INDEXDIR}/index.md"

</nav>
EOF

  bannerColor "Created index.md." "green" "*"

  cd ${script_dir}
  if [ $WEB ]; then
    bannerColor "Creating WEB files ..." "blue" "*"
    npm run web 
    bannerColor "Created web files." "green" "*"
    # remove webpub/lib, webpub/pdf, webpub/spec, webpub/src, webpub/LICENSE, webpub/mdap, webpub/package.json, webpub/pnpm-lock.yaml, README
    cd "webpub" || {
      echo 'Do not exist.'
      exit 1
    }
    bannerColor "Removing dirs ..." "cyan" "*"
    rm -rf lib pdf spec src
    bannerColor "Removing fils ..." "cyan" "*"
    rm LICENSE mdap package.json pnpm-lock.yaml README.md
  else
    bannerColor "Creating a PDF file ..." "blue" "*"
    npm run build >/dev/null
    bannerColor "PDF is created." "green" "*"

    # add cover page
    if [[ $COVER -gt 0 ]]; then
      bannerColor "Adding a cover page." "blue" "*"
      pdfunite "${script_dir}/${DOCUMENTS}/covers/${NAME}.pdf" "${DOCDIR}/${LANG}/${NAME}.pdf" "${DOCDIR}/${LANG}/${NAME}-${LANG}.pdf" >/dev/null 2>&1 || {
            echo "not able to combine pdfs."
            exit 1
        }
    else
      bannerColor "Moving the PDF file ..." "blue" "*"
      # create if dir doesn't exist
      if [ ! -d ${script_dir}/${DOCUMENTS}/${NAME}/${LANG} ];then
        mkdir -p ${script_dir}/${DOCUMENTS}/${NAME}/${LANG}
      fi
      mv "${script_dir}/${NAME}.pdf" "${script_dir}/${DOCUMENTS}/${NAME}/${LANG}/${NAME}-${LANG}.pdf"
    fi
      # if KEEP is on means leave the files
    if [[ $KEEP != 1 ]]; then
      bannerColor "Removing the previous ${WORKSPACE}." "blue" "*"
      rm -rf "${WORKSPACE:?Does not exist}/"
    fi
  fi

  if [[ $PREVIEW ]]; then
    bannerColor "Running preview ..." "blue" "*"
    npm run preview >/dev/null 
  fi
  
  # remove no cover pdf
  # if [ -f "${script_dir}/${DOCUMENTS}/${NAME}/${LANG}/${NAME}.pdf" ]; then
  #   rm "${script_dir}/${DOCUMENTS}/${NAME}/${LANG}/${NAME}.pdf"
  # fi

  # echo '' > "${script_dir}/${FILENAME1}"
  
  bannerColor "${NAME} ${LANG} files are created." "blue" "*"

  # move necessary files and dirs to /Users/shinichiokada/Vivliostyle/offlinedocs
  if [ $WEB ]; then
    case $NAME in
      bulletproof-react)
          fn_move_files 
          ;;
      express)
          fn_move_express
          ;;
      nestjs)
          fn_move_files
          ;;
      nuxt)
          fn_move_nuxt
          ;;
      pnpm)
          fn_move_files
          ;;
      react)
          fn_move_react
          ;;
      shellspec)
          fn_move_files
          ;;
      slidev)
          fn_move_slidev
          ;;
      svelte)
          fn_move_files
          ;;
      sveltekit)
          fn_move_sveltekit
          ;;
      tauri)
          fn_move_files
          ;;
      vite)
          fn_move_files
          ;;
      vitepress)
          fn_move_files
          ;;
      vitest)
          fn_move_files
          ;;
      vue)
          fn_move_vue
          ;;
      *)
          fn_move_files
          ;;
      # more lines
      --) ;; # no subcommand, arguments only
      esac
  fi
}
