get_tauri_category_title(){
  file=$1
  pathname="${line/$WORKSPACE\/}"
  
  category="${pathname%/*}"
  # remove all "
  category="${category//\"/}"
  # replace / with a space
  # category=$(sed 's/\// /' "$category")
  category="${category/\// }"

  title="${pathname##*/}"
  # remove the last 5 characters, .md
  title="${title::-5}"
  # capitalize the first letter
  TITLE="${category^^} - ${title^}"
  echo "$TITLE"
}

fn_move_tauri(){
  newBannerColor "Removing old files and dirs from ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove the old dir
  rm -Rf ${WEBAPP}/${NAME}/${LANG}
  # create a new dir
  mkdir -p ${WEBAPP}/${NAME}/${LANG} 
  newBannerColor "Removed old files and dir." "green" "*"

  newBannerColor "Removing all non-HTML files from ${WORKSPACE} ..." "blue" "*"
  find ${WORKSPACE} -type f -not -name '*.html' -delete
  newBannerColor "Successfully removed non-HTML files." "green" "*"

  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/api && cp -r ${WORKSPACE}/api/*.html ${WEBAPP}/${NAME}/${LANG}/api
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/api/js && cp -r ${WORKSPACE}/api/js/*.html ${WEBAPP}/${NAME}/${LANG}/api/js
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/guides && cp -r ${WORKSPACE}/guides/*.html ${WEBAPP}/${NAME}/${LANG}/guides
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/guides/building && cp -r ${WORKSPACE}/guides/building/*.html ${WEBAPP}/${NAME}/${LANG}/guides/building
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/guides/debugging && cp -r ${WORKSPACE}/guides/debugging/*.html ${WEBAPP}/${NAME}/${LANG}/guides/debugging
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/guides/development && cp -r ${WORKSPACE}/guides/development/*.html ${WEBAPP}/${NAME}/${LANG}/guides/development
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/guides/distribution && cp -r ${WORKSPACE}/guides/distribution/*.html ${WEBAPP}/${NAME}/${LANG}/guides/distribution
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/guides/features && cp -r ${WORKSPACE}/guides/features/*.html ${WEBAPP}/${NAME}/${LANG}/guides/features
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/guides/getting-started && cp -r ${WORKSPACE}/guides/getting-started/*.html ${WEBAPP}/${NAME}/${LANG}/guides/getting-started
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/guides/testing && cp -r ${WORKSPACE}/guides/getting-started/*.html ${WEBAPP}/${NAME}/${LANG}/guides/testing
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/references && cp -r ${WORKSPACE}/references/*.html ${WEBAPP}/${NAME}/${LANG}/references
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/references/architecture && cp -r ${WORKSPACE}/references/architecture/*.html ${WEBAPP}/${NAME}/${LANG}/references/architecture
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/references/architecture/inter-process-communication && cp -r ${WORKSPACE}/references/architecture/inter-process-communication/*.html ${WEBAPP}/${NAME}/${LANG}/references/architecture/inter-process-communication
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/references/architecture/recipes && cp -r ${WORKSPACE}/references/architecture/recipes/*.html ${WEBAPP}/${NAME}/${LANG}/references/architecture/recipes
  # cp ${WORKSPACE}/{index.html,colophon.html} ${WEBAPP}/${NAME}/${LANG}
  newBannerColor "Minifying HTML files and outputting to ${WEBAPP}/${NAME}/${LANG}." "blue" "*"
  # minify to ${WEBAPP}/${NAME}/${LANG}
  html-minifier  --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --minify-css true --minify-js true --input-dir ${WORKSPACE} --output-dir ${WEBAPP}/${NAME}/${LANG}
  newBannerColor "Successfully minified and moved." "green" "*"
}

