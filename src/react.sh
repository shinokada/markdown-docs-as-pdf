fn_react(){
  if [ $WEB ]; then
    # ${self} create -n react -l it create a problem
    newBannerColor "Creating all React web docs ..." "blue" "*"
    ${self} create -n react -w && ${self} create -n react -w -l de && ${self} create -n react -w -l fr && ${self} create -n react -w -l he && ${self} create -n react -w -l ja && ${self} create -n react -w -l ko && ${self} create -n react -w -l pl && ${self} create -n react -w -l zh-hans && ${self} create -n react -w -l zh-hant
  else
    # reate -n react -l it create a problem
    newBannerColor "Creating all React PDFs ..." "blue" "*"
    ${self} create -n react && ${self} create -n react -l de && ${self} create -n react -l fr && ${self} create -n react -l he && ${self} create -n react -l ja && ${self} create -n react -l ko && ${self} create -n react -l pl && ${self} create -n react -l zh-hans && ${self} create -n react -l zh-hant
  fi
}