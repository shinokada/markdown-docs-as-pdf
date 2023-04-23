clean_vitest(){
  file=$1
  # 1. change :::tip to <blockquote>, 2. add line break after Note
  # 3. change ::: to </blockquote>, 4. ](/docs/ to ](./docs/
  sed -i -e 's/\:\:\: tip/\<blockquote\>/' \
  -e 's/\:\:\:tip/\<blockquote\>/' \
  -e 's/\:\:\: warning/\<blockquote\>/' \
  -e 's/\:\:\:warning/\<blockquote\>/' \
  -e '/Note/G' \
  -e 's/\:\:\:/\<\/blockquote\>/' "$file"
  
  fix_link_without_dot_html "$file"
}
