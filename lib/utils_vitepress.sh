clean_vitepress(){
  file=$1
  # change [when creating your own theme](./theme-introduction) 
  # to 
  # [when creating your own theme](./theme-introduction.html)
  # [Base URL](./asset-handling#base-url) to [Base URL](./asset-handling.html#base-url)
  # pattern ](./ 
  # add .html before )
  sed -i 's/](\(\.\/.*\))/](\1.html)/g' $file
  # add .html before #
  sed -i 's/](\(\.\/.*\)#/](\1.html#/g' $file
}