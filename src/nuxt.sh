fn_nuxt(){
  if [ $WEB ]; then
    newBannerColor "Creating all Nuxt web docs ..." "magenta" "*"
    ${self} create -n nuxt -w  && ${self} create -n nuxt -w -l es  && ${self} create -n nuxt -w -l fr  && ${self} create -n nuxt -w -l ja  && ${self} create -n nuxt -w -l pt-br  && ${self} create -n nuxt -w -l pt
  else
    newBannerColor "Creating all Nuxt PDFs ..." "magenta" "*"
    ${self} create -n nuxt  && ${self} create -n nuxt -l es  && ${self} create -n nuxt -l fr  && ${self} create -n nuxt -l ja  && ${self} create -n nuxt -l pt-br  && ${self} create -n nuxt -l pt
  fi
}