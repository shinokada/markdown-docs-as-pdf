fn_nuxt(){
  if [ $WEB ]; then
    bannerColor "Creating all Nuxt web docs ..." "magenta" "*"
    $(${self} create -n nuxt -w >/dev/null 2>&1 && ${self} create -n nuxt -w -l es >/dev/null 2>&1 && ${self} create -n nuxt -w -l fr >/dev/null 2>&1 && ${self} create -n nuxt -w -l ja >/dev/null 2>&1 && ${self} create -n nuxt -w -l pt-br >/dev/null 2>&1 && ${self} create -n nuxt -w -l pt >/dev/null 2>&1)
  else
    bannerColor "Creating all Nuxt PDFs ..." "magenta" "*"
    $(${self} create -n nuxt >/dev/null 2>&1 && ${self} create -n nuxt -l es >/dev/null 2>&1 && ${self} create -n nuxt -l fr >/dev/null 2>&1 && ${self} create -n nuxt -l ja >/dev/null 2>&1 && ${self} create -n nuxt -l pt-br >/dev/null 2>&1 && ${self} create -n nuxt -l pt >/dev/null 2>&1)
  fi
}