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