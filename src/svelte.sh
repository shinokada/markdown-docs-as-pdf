fn_svelte(){
  if [ $WEB ]; then
    newBannerColor "Creating all Svelte web docs ..." "blue" "*"
    ${self} create -n svelte -w && ${self} create -n svelte -w -l ja
  else
    newBannerColor "Creating all Svelte PDF docs ..." "blue" "*"
    ${self} create -n svelte && ${self} create -n svelte -l ja
  fi
}
