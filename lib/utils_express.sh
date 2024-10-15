clean_express(){
  file=$1
  # Change /{{ page.lang }} to .. 
  sed -i "s/\/{{ page.lang }}/../g" $file
  # change ](/ to ](../
  sed -i "s/](\//](..\//g" $file
  # remove {% include community-caveat.html %}
  sed -i 's/{% include community-caveat.html %}//g' $file
}

fn_move_express(){
  newBannerColor "Removing old files and dirs from ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove old dirs
  rm -rf ${WEBAPP}/${NAME}/${LANG}
  # create a new dir
  mkdir -p ${WEBAPP}/${NAME}/${LANG} 
  newBannerColor "Successfully removed old dir from." "green" "*"
  
  # remove non-html files 
  newBannerColor "Removing all non-HTML files from ${WORKSPACE} ..." "blue" "*"
  find ${WORKSPACE} -type f -not -name '*.html' -delete
  newBannerColor "Successfully removed non-HTML files." "green" "*"

  newBannerColor "Minifying HTML files and outputting to ${WEBAPP}/${NAME}/${LANG}." "blue" "*"
  # minify to ${WEBAPP}/${NAME}/${LANG}
  html-minifier  --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --minify-css true --minify-js true --input-dir ${WORKSPACE}/${LANG} --output-dir ${WEBAPP}/${NAME}/${LANG}
  newBannerColor "Successfully minified and moved." "green" "*"
  # mkdir -p ${WEBAPP}/${NAME}/${LANG} && cp -r ${WORKSPACE}/*.html ${WEBAPP}/${NAME}/${LANG}
}