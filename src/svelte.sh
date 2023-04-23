fn_svelte(){
  if [ $WEB ]; then
    bannerColor "Creating all Svelte web docs ..." "blue" "*"
    ${self} create -n svelte -w && ${self} create -n svelte -w -l ja
  else
    bannerColor "Creating all Svelte PDF docs ..." "blue" "*"
    ${self} create -n svelte && ${self} create -n svelte -l ja
  fi
}
