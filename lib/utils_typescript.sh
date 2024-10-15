get_typescript_category_title(){
  line=$1

  IFS='/' read -ra line_array <<< "$line"
  title="${line_array[-1]}" # 10-introduction.md
  category="${line_array[-2]}" # 10-getting-started

  # remove the last 5 characters, .md
  title="${title::-5}"
  # replace - with space, first letter uppercase
  # newBannerColor "Replacing - with space, first letter uppercase ..." "cyan" "*"
  title="$(clean_word $title)"
  # printf $title
  # newBannerColor "Replacing - with space, first letter uppercase ..." "magenta" "*"
  category="$(clean_word $category)"
  # printf $category
  # combine to to create TITLE
  TITLE="${category} - ${title}"
  # printf "Title is: $TITLE"
  echo "$TITLE"
}