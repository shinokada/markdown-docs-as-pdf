fn_react(){
  if [ $WEB ]; then
    # ${self} create -n react -l it create a problem
    bannerColor "Creating all React web docs ..." "blue" "*"
    ${self} create -n react -w >/dev/null 2>&1 && ${self} create -n react -w -l de >/dev/null 2>&1 && ${self} create -n react -w -l fr >/dev/null 2>&1 && ${self} create -n react -w -l he >/dev/null 2>&1 && ${self} create -n react -w -l ja >/dev/null 2>&1 && ${self} create -n react -w -l ko >/dev/null 2>&1 && ${self} create -n react -w -l pl >/dev/null 2>&1 && ${self} create -n react -w -l zh-hans >/dev/null 2>&1 && ${self} create -n react -w -l zh-hant >/dev/null 2>&1
  else
    # reate -n react -l it create a problem
    bannerColor "Creating all React PDFs ..." "blue" "*"
    ${self} create -n react >/dev/null 2>&1 && ${self} create -n react -l de >/dev/null 2>&1 && ${self} create -n react -l fr >/dev/null 2>&1 && ${self} create -n react -l he >/dev/null 2>&1 && ${self} create -n react -l ja >/dev/null 2>&1 && ${self} create -n react -l ko >/dev/null 2>&1 && ${self} create -n react -l pl >/dev/null 2>&1 && ${self} create -n react -l zh-hans >/dev/null 2>&1 && ${self} create -n react -l zh-hant >/dev/null 2>&1
  fi
}