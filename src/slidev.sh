fn_slidev(){
  bannerColor "Creating all Slidev docs ..." "green" "*"
  $(${self} create -n slidev >/dev/null 2>&1 && ${self} create -n slidev -l br >/dev/null 2>&1 && ${self} create -n slidev -l cn >/dev/null 2>&1 && ${self} create -n slidev -l de >/dev/null 2>&1 && ${self} create -n slidev -l el >/dev/null 2>&1 && ${self} create -n slidev -l es >/dev/null 2>&1 && ${self} create -n slidev -l fr >/dev/null 2>&1 && ${self} create -n slidev -l ja >/dev/null 2>&1 && ${self} create -n slidev -l ru >/dev/null 2>&1 && ${self} create -n slidev -l vn >/dev/null 2>&1 )
}