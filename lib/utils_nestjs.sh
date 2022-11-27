clean_nestjs(){
  file=$1
  # change <img src="/assets/enterprise/help.svg" /> to
  # <img src="${WORKSPACE}/src/assets/enterprise/help.svg" />
  sed -i "s|src=\"/assets|src=\"${WORKSPACE}/src/assets|g" $file
}

fn_move_nestjs(){
  bannerColor "Removing old files and dirs from ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove the old dir
  rm -Rf ${WEBAPP}/${NAME}/${LANG}/*
  bannerColor "Removed old files and dir from ${WEBAPP}/${NAME}/${LANG}." "green" "*"
  # move /content/en/docs
  mkdir -p ${WEBAPP}/${NAME}/${LANG} && cp -r ${WORKSPACE}/content/${LANG}/docs/*.html ${WEBAPP}/${NAME}/${LANG}
  cp ${WORKSPACE}/content/${LANG}/docs/{index.html,colophon.html} ${WEBAPP}/${NAME}/${LANG}
  # move images
  cp -r ${WORKSPACE}/static/img/docs ${WEBAPP}/${NAME}/${LANG}
}