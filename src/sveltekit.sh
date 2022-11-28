fn_sveltekit(){
  if [ $WEB ]; then
    bannerColor "Creating all SvelteKit web docs ..." "magenta" "*"
    ${self} create -n sveltekit -w && ${self} create -n sveltekit -w -l ja
  else
    bannerColor "Creating all SvelteKit PDF ..." "magenta" "*"
    ${self} create -n sveltekit && ${self} create -n sveltekit -l ja
  fi
}