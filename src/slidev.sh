fn_slidev(){
  if [ $WEB ]; then
    bannerColor "Creating all Slidev web docs ..." "green" "*"
    $(${self} create -n slidev -w >/dev/null 2>&1 && ${self} create -n slidev -w -l br >/dev/null 2>&1 && ${self} create -n slidev -w -l cn >/dev/null 2>&1 && ${self} create -n slidev -w -l de >/dev/null 2>&1 && ${self} create -n slidev -w -l el >/dev/null 2>&1 && ${self} create -n slidev -w -l es >/dev/null 2>&1 && ${self} create -n slidev -w -l fr >/dev/null 2>&1 && ${self} create -n slidev -w -l ja >/dev/null 2>&1 && ${self} create -n slidev -w -l ru >/dev/null 2>&1 && ${self} create -n slidev -w -l vn >/dev/null 2>&1 )
  else
    bannerColor "Creating all Slidev PDFs ..." "green" "*"
    $(${self} create -n slidev >/dev/null 2>&1 && ${self} create -n slidev -l br >/dev/null 2>&1 && ${self} create -n slidev -l cn >/dev/null 2>&1 && ${self} create -n slidev -l de >/dev/null 2>&1 && ${self} create -n slidev -l el >/dev/null 2>&1 && ${self} create -n slidev -l es >/dev/null 2>&1 && ${self} create -n slidev -l fr >/dev/null 2>&1 && ${self} create -n slidev -l ja >/dev/null 2>&1 && ${self} create -n slidev -l ru >/dev/null 2>&1 && ${self} create -n slidev -l vn >/dev/null 2>&1 )
  fi

}