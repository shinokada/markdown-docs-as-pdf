fn_all(){
  bannerColor "Creating all docs. It takes a loooooong time. Be patient." "blue" "*"
  $(${self} create -n bulletproof-react >/dev/null 2>&1 && ${self} nuxt >/dev/null 2>&1 && ${self} create -n pnpm >/dev/null 2>&1 && ${self} react >/dev/null 2>&1 && ${self} create -n shellspec >/dev/null 2>&1 && ${self} slidev >/dev/null 2>&1 && ${self} svelte >/dev/null 2>&1 && ${self} sveltekit >/dev/null 2>&1 && ${self} create -n tauri >/dev/null 2>&1 && ${self} create -n vite >/dev/null 2>&1 && ${self} create -n vitepress >/dev/null 2>&1 && ${self} vitest >/dev/null 2>&1)
}