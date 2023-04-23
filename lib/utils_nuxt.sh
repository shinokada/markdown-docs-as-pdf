clean_nuxt(){
  sed -i -e 's/::code-group//g' \
  -e 's/::alert{type="info"}/#### Info/g' \
  -e 's/::alert{type="warning"}/#### Warning/g' \
  -e 's/::alert{type="next"}/#### Next/g' \
  -e 's/:://g' "${file}"
  # sed -i 's/::/<\/block>/g' "${file}"
}

fn_move_nuxt(){
  bannerColor "Removing old files and dirs and create a new ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove the old dir
  rm -Rf ${WEBAPP}/${NAME}/${LANG}
  # create a new dir
  mkdir -p ${WEBAPP}/${NAME}/${LANG} 
  bannerColor "Successfully removed old dir and create a new dir." "green" "*"
  
  bannerColor "Moving image files ..." "blue" "*"
  # move images
  cp -r ${WORKSPACE}/static/img/docs ${WEBAPP}/${NAME}/${LANG}
  bannerColor "Successfully moved image files." "green" "*"

  # remove non-html files 
  bannerColor "Removing all non-HTML files from ${WORKSPACE} ..." "blue" "*"
  find ${WORKSPACE} -type f -not -name '*.html' -delete
  bannerColor "Successfully removed non-HTML files." "green" "*"

  bannerColor "Minifying HTML files and outputting to ${WEBAPP}/${NAME}/${LANG}." "blue" "*"
  # minify to ${WEBAPP}/${NAME}/${LANG}
  html-minifier  --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --minify-css true --minify-js true --input-dir ${WORKSPACE}/content/${LANG}/docs --output-dir ${WEBAPP}/${NAME}/${LANG}
  bannerColor "Successfully minified and moved." "green" "*"
}

