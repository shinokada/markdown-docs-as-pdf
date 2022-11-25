get_tauri_category_title(){
  file=$1
  pathname="${line/$WORKSPACE\/}"
  
  category="${pathname%/*}"
  # remove all "
  category="${category//\"/}"
  # replace / with a space
  # category=$(sed 's/\// /' "$category")
  category="${category/\// }"

  title="${pathname##*/}"
  # remove the last 5 characters, .md
  title="${title::-5}"
  # capitalize the first letter
  TITLE="${category^^} - ${title^}"
  echo "$TITLE"
}

