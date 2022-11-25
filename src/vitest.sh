fn_vitest(){
  bannerColor "Creating all Vitest docs ..." "blue" "*"
  $(${self} create -n vitest >/dev/null 2>&1 && ${self} create -n vitest -l cn >/dev/null 2>&1)
}