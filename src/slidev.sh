fn_slidev(){
  if [ $WEB ]; then
    bannerColor "Creating all Slidev web docs ..." "green" "*"
    ${self} create -n slidev -w && ${self} create -n slidev -w -l br && ${self} create -n slidev -w -l cn && ${self} create -n slidev -w -l de && ${self} create -n slidev -w -l el && ${self} create -n slidev -w -l es && ${self} create -n slidev -w -l fr && ${self} create -n slidev -w -l ja && ${self} create -n slidev -w -l ru && ${self} create -n slidev -w -l vn
  else
    bannerColor "Creating all Slidev PDFs ..." "green" "*"
    ${self} create -n slidev && ${self} create -n slidev -l br && ${self} create -n slidev -l cn && ${self} create -n slidev -l de && ${self} create -n slidev -l el && ${self} create -n slidev -l es && ${self} create -n slidev -l fr && ${self} create -n slidev -l ja && ${self} create -n slidev -l ru && ${self} create -n slidev -l vn
  fi

}