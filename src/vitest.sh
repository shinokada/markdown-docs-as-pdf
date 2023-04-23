fn_vitest(){
  if [ $WEB ]; then
    bannerColor "Creating all Vitest docs ..." "blue" "*"
    ${self} create -n vitest -w && ${self} create -n vitest -w -l cn
  else
    bannerColor "Creating all Vitest docs ..." "blue" "*"
    ${self} create -n vitest && ${self} create -n vitest -l cn
  fi
}