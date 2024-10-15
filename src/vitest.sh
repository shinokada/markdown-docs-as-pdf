fn_vitest(){
  if [ $WEB ]; then
    newBannerColor "Creating all Vitest docs ..." "blue" "*"
    ${self} create -n vitest -w && ${self} create -n vitest -w -l cn
  else
    newBannerColor "Creating all Vitest docs ..." "blue" "*"
    ${self} create -n vitest && ${self} create -n vitest -l cn
  fi
}