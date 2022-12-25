fn_all(){
  if [ $WEB ]; then
    bannerColor "Creating all docs. It takes a long time. Be patient." "blue" "*"
    ${self} create -n bulletproof-react -w && ${self} nuxt -w && ${self} create -n pnpm -w && ${self} react -w && ${self} create -n shellspec -w && ${self} slidev -w && ${self} svelte -w && ${self} sveltekit -w  && ${self} create -n tauri -w && ${self} create -n vite -w  && ${self} create -n vitepress -w && ${self} vitest -w && ${self} create -n zod -w
  else
    bannerColor "Creating all PDFs. It takes a loooooong time. Be patient." "blue" "*"
    ${self} create -n bulletproof-react && ${self} nuxt && ${self} create -n pnpm && ${self} react && ${self} create -n shellspec && ${self} slidev && ${self} svelte && ${self} sveltekit && ${self} create -n tauri && ${self} create -n vite && ${self} create -n vitepress && ${self} vitest && ${self} create -n zod 
  fi
}