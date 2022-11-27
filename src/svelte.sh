fn_svelte(){
  if [ $WEB ]; then
    bannerColor "Creating all Svelte web docs ..." "blue" "*"
    $(${self} create -n svelte -w >/dev/null 2>&1 && ${self} create -n svelte -w -l ja >/dev/null 2>&1)
  else
    bannerColor "Creating all Svelte PDF docs ..." "blue" "*"
    $(${self} create -n svelte >/dev/null 2>&1 && ${self} create -n svelte -l ja >/dev/null 2>&1)
  fi
}
