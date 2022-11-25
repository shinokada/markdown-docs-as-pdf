clean_nestjs(){
  file=$1
  # change <img src="/assets/enterprise/help.svg" /> to
  # <img src="${WORKSPACE}/src/assets/enterprise/help.svg" />
  sed -i "s|src=\"/assets|src=\"${WORKSPACE}/src/assets|g" $file
}