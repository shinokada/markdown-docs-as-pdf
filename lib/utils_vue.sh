fn_move_vue(){
  newBannerColor "Removing old files and dirs from ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove the old dir
  rm -Rf ${WEBAPP}/${NAME}/${LANG}
  # create a new dir
  mkdir -p ${WEBAPP}/${NAME}/${LANG} 
  newBannerColor "Removed old files and dir." "green" "*"

  newBannerColor "Removing all non-HTML files from ${WORKSPACE} ..." "blue" "*"
  find ${WORKSPACE} -type f -not -name '*.html' -delete
  newBannerColor "Successfully removed non-HTML files." "green" "*"



  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/best-practices && cp -r ${WORKSPACE}/best-practices/*.html ${WEBAPP}/${NAME}/${LANG}/best-practices
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/built-ins && cp -r ${WORKSPACE}/built-ins/*.html ${WEBAPP}/${NAME}/${LANG}/built-ins
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/components && cp -r ${WORKSPACE}/components/*.html ${WEBAPP}/${NAME}/${LANG}/components
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/essentials && cp -r ${WORKSPACE}/essentials/*.html ${WEBAPP}/${NAME}/${LANG}/essentials
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/extras && cp -r ${WORKSPACE}/extras/*.html ${WEBAPP}/${NAME}/${LANG}/extras
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/reusability && cp -r ${WORKSPACE}/reusability/*.html ${WEBAPP}/${NAME}/${LANG}/reusability
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/scaling-up && cp -r ${WORKSPACE}/scaling-up/*.html ${WEBAPP}/${NAME}/${LANG}/scaling-up
  # mkdir -p ${WEBAPP}/${NAME}/${LANG}/typescript && cp -r ${WORKSPACE}/typescript/*.html ${WEBAPP}/${NAME}/${LANG}/typescript

  # cp ${WORKSPACE}/{index.html,colophon.html} ${WEBAPP}/${NAME}/${LANG}

  newBannerColor "Minifying HTML files and outputting to ${WEBAPP}/${NAME}/${LANG}." "blue" "*"
  # minify to ${WEBAPP}/${NAME}/${LANG}
  html-minifier  --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --minify-css true --minify-js true --input-dir ${WORKSPACE} --output-dir ${WEBAPP}/${NAME}/${LANG}
  newBannerColor "Successfully minified and moved." "green" "*"
 
}