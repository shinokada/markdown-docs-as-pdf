fix_pnpm_link(){
  file=$1
  # [workspace protocol]: ./workspaces.md#workspace-protocol-workspace
  # to [workspace protocol](workspaces.html)
  # [AppVeyor]: https://www.appveyor.com
  # to [AppVeyor](https://www.appveyor.com)
  # sed "/${contain}/s/${search}/${replace}/g" $file
  # replace ]: to ](
  # 1. replace : https to (https 2. where (https is add ) to the end $.
  sed -i -e 's/: https/(https/' \
  -e '/(https/ s/$/) &/' $file
  # 1. replace : ./ to ( 2. replace .md and after all characters to .html)
  sed -i 's/: .\//(/g' $file
  sed -i 's/.md[^ ]*/.html)/g' $file
  # 1. replace (package_json# to (package_json.html)
  sed -i 's/(package_json#[^ ]*/(package_json.html)/g' $file
}

get_pnpm_title() {
  file=$1
  # 1. Remove ---
  # 2. change title: to # 
  sed -i -e 's/---//' \
  -e 's/title:/#/' \
  -e "/id:/d" "${file}"
}