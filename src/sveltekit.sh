fn_sveltekit(){
  if [ $WEB ]; then
    bannerColor "Creating all SvelteKit web docs ..." "magenta" "*"
    $(${self} create -n sveltekit -w >/dev/null 2>&1 && ${self} create -n sveltekit -w -l ja >/dev/null 2>&1)
  else
    bannerColor "Creating all SvelteKit PDF ..." "magenta" "*"
    $(${self} create -n sveltekit >/dev/null 2>&1 && ${self} create -n sveltekit -l ja >/dev/null 2>&1)
  fi
}