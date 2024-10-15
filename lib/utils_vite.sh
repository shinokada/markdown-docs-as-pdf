
clean_vite() {
  file=$1
  # newBannerColor "Start running clean_vite function for $file ..." "blue" "*"
  # 1. change :::tip to <blockquote>, 2. add line break after Note
  # 3. change ::: to </blockquote>, 4. ](/docs/ to ](./docs/
  sed -i -e 's/\:\:\:tip/\<blockquote\>/' \
  -e '/Note/G' \
  -e 's/\:\:\:/\<\/blockquote\>/' "$file"
  # newBannerColor "Running fix_line function for $file ..." "blue" "*"
  fix_link "$file"
  # newBannerColor "Running fix_link_html for $file ..." "blue" "*"
  fix_link_html "$file"
}
