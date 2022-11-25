fn_react(){
  # ${self} create -n react -l it create a problem
  bannerColor "Creating all React docs ..." "blue" "*"
  $(${self} create -n react >/dev/null 2>&1 && ${self} create -n react -l de >/dev/null 2>&1 && ${self} create -n react -l fr >/dev/null 2>&1 && ${self} create -n react -l he >/dev/null 2>&1 && ${self} create -n react -l ja >/dev/null 2>&1 && ${self} create -n react -l ko >/dev/null 2>&1 && ${self} create -n react -l pl >/dev/null 2>&1 && ${self} create -n react -l zh-hans >/dev/null 2>&1 && ${self} create -n react -l zh-hant >/dev/null 2>&1)
}