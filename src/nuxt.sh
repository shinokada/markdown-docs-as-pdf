fn_nuxt(){
  bannerColor "Creating all Nuxt docs ..." "magenta" "*"
  $(${self} create -n nuxt >/dev/null 2>&1 && ${self} create -n nuxt -l es >/dev/null 2>&1 && ${self} create -n nuxt -l fr >/dev/null 2>&1 && ${self} create -n nuxt -l ja >/dev/null 2>&1 && ${self} create -n nuxt -l pt-br >/dev/null 2>&1 && ${self} create -n nuxt -l pt >/dev/null 2>&1)
}