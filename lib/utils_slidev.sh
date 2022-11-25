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