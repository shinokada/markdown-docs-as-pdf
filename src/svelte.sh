fn_svelte(){
  bannerColor "Creating all Svelte docs ..." "blue" "*"
  $(${self} create -n svelte >/dev/null 2>&1 && ${self} create -n svelte -l ja >/dev/null 2>&1)
}