fn_sveltekit(){
  if [ $WEB ]; then
    newBannerColor "Creating all SvelteKit web docs ..." "magenta" "*"
    ${self} create -n sveltekit -w && ${self} create -n sveltekit -w -l ja
  else
    newBannerColor "Creating all SvelteKit PDF ..." "magenta" "*"
    ${self} create -n sveltekit && ${self} create -n sveltekit -l ja
  fi
}