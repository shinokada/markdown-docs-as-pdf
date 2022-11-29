clean_slidev_internal_link(){
  file=$1
  # [Navigation](/guide/navigation#navigation-bar) to
  # [Navigation](guide/navigation.html)
  # change #navigation-bar) to .html)
  # change ](/ to ](
  sed -i '/](\// s/#[^ ]*/.html)/' $file
  sed -i 's/](\//](/' $file
  # other links are not fixed yet
  # [slides overview](#slides-overview) to [slides overview](slides-overview.html)
  # [**Interactive**](/custom/directory-structure.html#components)
  # [**Presenter Mode**](/guide/presenter-mode.html)
  
  # change ![](screenshots/navbar.png) to ![](../public/screenshots/navbar.png)
  # don't forget to escape $.*[\^ 
  sed -i 's|!\[](screenshots|!\[](../public/screenshots|' $file
}

fn_move_slidev(){
  bannerColor "Removing old files and dirs from ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove the old dir
  rm -Rf ${WEBAPP}/${NAME}/${LANG}
  # create a new dir
  mkdir -p ${WEBAPP}/${NAME}/${LANG} 
  bannerColor "Removed old files and dir." "green" "*"
  
  bannerColor "Moving image files ..." "blue" "*"
  # images
  mkdir -p ${WEBAPP}/${NAME}/${LANG}/public && cp -r ${WORKSPACE}/public/screenshots/ ${WEBAPP}/${NAME}/${LANG}/public
  bannerColor "Successfully moved image files." "green" "*"

  bannerColor "Removing ${WORKSPACE}.vitepress dir ..." "blue" "*"
  rm -rf ${WORKSPACE}/.vitepress
  bannerColor "Successfully removed the dir." "green" "*"

  # remove non-html files 
  bannerColor "Removing all non-HTML files from ${WORKSPACE} ..." "blue" "*"
  find ${WORKSPACE} -type f -not -name '*.html' -delete
  bannerColor "Successfully removed non-HTML files." "green" "*"

  bannerColor "Minifying HTML files and outputting to ${WEBAPP}/${NAME}/${LANG}." "blue" "*"
  # minify to ${WEBAPP}/${NAME}/${LANG}
  html-minifier  --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --minify-css true --minify-js true --input-dir ${WORKSPACE} --output-dir ${WEBAPP}/${NAME}/${LANG}
  bannerColor "Successfully minified and moved." "green" "*"
  
}