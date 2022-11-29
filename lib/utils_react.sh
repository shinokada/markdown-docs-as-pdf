fn_move_react(){
  bannerColor "Removing old files and dirs from ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove the old dir
  rm -Rf ${WEBAPP}/${NAME}/${LANG}
  # create a new dir
  mkdir -p ${WEBAPP}/${NAME}/${LANG} 
  bannerColor "Removed old files and dir." "green" "*"

  bannerColor "Moving image files ..." "blue" "*"
  cp -r ${WORKSPACE}/images/docs ${WEBAPP}/${NAME}/${LANG}
  bannerColor "Successfully moved image files." "green" "*"
 
  bannerColor "Removing all non-HTML files from ${WORKSPACE} ..." "blue" "*"
  find ${WORKSPACE} -type f -not -name '*.html' -delete
  bannerColor "Successfully removed non-HTML files." "green" "*"

  bannerColor "Minifying HTML files and outputting to ${WEBAPP}/${NAME}/${LANG}." "blue" "*"
  html-minifier  --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --minify-css true --minify-js true --input-dir ${WORKSPACE}/docs --output-dir ${WEBAPP}/${NAME}/${LANG}
  bannerColor "Successfully minified and moved." "green" "*"
}



get_react_title() {
  file=$1
  # 1. Remove ---
  # 2. change title: to # 
  # 3. delete line with id:, permalink:, layout:, category:, next:, prev:, redirect_from:, - "docs/, - "tips/, - "contributing/, - "download
  sed -i -e 's/---//' \
  -e 's/title:/#/' \
  -e "/id:/d" \
  -e "/permalink:/d" \
  -e "/layout:/d" \
  -e "/category:/d" \
  -e "/next:/d" \
  -e "/prev:/d" \
  -e "/redirect_from:/d" \
  -e "/- \"docs\//d" \
  -e "/- \"tips\//d" \
  -e "/- \"contributing\//d" \
  -e "/- \"download\//d" "${file}"
}