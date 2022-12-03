fn_express(){
  if [ $WEB ]; then
    bannerColor "Creating all Express web docs ..." "magenta" "*"
    ${self} create -n express -w && ${self} create -n express -w -l de && ${self} create -n express -w -l es && ${self} create -n express -w -l fr && ${self} create -n express -w -l it && ${self} create -n express -w -l ja && ${self} create -n express -w -l ru && ${self} create -n express -w -l zh-cn && ${self} create -n express -w -l zh-tw && ${self} create -n express -w -l ko && ${self} create -n express -w -l pt-br
  else
    bannerColor "Creating all Express PDFs ..." "magenta" "*"
    ${self} create -n express && ${self} create -n express -l de && ${self} create -n express -l es && ${self} create -n express -l fr && ${self} create -n express -l it && ${self} create -n express -l ja && ${self} create -n express -l ru && ${self} create -n express -l zh-cn && ${self} create -n express -l zh-tw && ${self} create -n express -l ko && ${self} create -n express -l pt-br
  fi
}