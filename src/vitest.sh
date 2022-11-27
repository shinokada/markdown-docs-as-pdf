fn_vitest(){
  if [ $WEB ]; then
    bannerColor "Creating all Vitest docs ..." "blue" "*"
    $(${self} create -n vitest -w >/dev/null 2>&1 && ${self} create -n vitest -w -l cn >/dev/null 2>&1)
  else
    bannerColor "Creating all Vitest docs ..." "blue" "*"
    $(${self} create -n vitest >/dev/null 2>&1 && ${self} create -n vitest -l cn >/dev/null 2>&1)
  fi
}