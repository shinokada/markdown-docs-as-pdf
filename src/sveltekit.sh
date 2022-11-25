fn_sveltekit(){
  bannerColor "Creating all SvelteKit docs ..." "magenta" "*"
  $(${self} create -n sveltekit >/dev/null 2>&1 && ${self} create -n sveltekit -l ja >/dev/null 2>&1)
}