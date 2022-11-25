# PDF Documentation 

You can find all the docs in the [pdf directory](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf).

## Available PDF

### Nestjs

| Name | Languages | Link |
|--|---|--|
| Nestjs| en| [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/nestjs)|

### React family

| Name | Languages | Link |
|--|---|--|
|React| en, de, fr, he, it, ja, ko, pl, zh-hans, zh-hant |[docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/react) |

### Svelte family

| Name | Languages | Link |
|--|---|--|
|Svelte| en, ja |[docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/svelte)|
| SvelteKit| en, ja | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/sveltekit)|

### Vite family

| Name | Languages | Link |
|--|---|--|
|Vite|en| [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/vite)|
| Vitest| en | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/vitest)|

### Vue family

| Name | Languages | Link |
|--|---|--|
|Nuxt| en, es, fr, ja, pt-br, pt | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/nuxt)|
|Slidev| en, br, cn, de, el, es, fr, ja, ru, vn|[docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/slidev)|
|Vue| Not complete  | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/vue)|
| Vitepress | en | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/vitepress)|


## Other pdf docs

| Name | Languages | Link |
|--|--|--|
| pnpm | en | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/pnpm)|
| Shellspec | en | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/shellspec) |
| Tauri | en | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/tauri) |
| Bullet proof React | en | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/bulletproof-react)|

## Limitations

All the TOC links work but some of internal links don't work due to each documentation has different way of linking to pages.

## How to use this script

### Requirements

- Bash > v5
- vivliostyle, To convert markdown files to a PDF file.
- pdfunite

### Getting started

```sh
git clone git@github.com:shinokada/svelte-docs.git
cd svelte-docs
pnpm i
./mdap --help
```

## Commands

### Nest

```
./mdap create -n nest
```

### Nuxt

```
# Nuxt in all languages
./mdap nuxt
```

### pnpm

```
./mdap create -n pnpm
```

### React all docs

```
# All lanugages
./mdap react

# Individual doc:
./mdap create -n react  
./mdap create -n react -l de  
./mdap create -n react -l fr  
./mdap create -n react -l he 
./mdap create -n react -l it 
./mdap create -n react -l ja 
./mdap create -n react -l ko 
./mdap create -n react -l pl 
./mdap create -n react -l zh-hans 
./mdap create -n react -l zh-hant
```

### shellspec

```
./mdap create -n shellspec
```

### slidev

```
# Slidev in all languages
./mdap slidev

# individual language
./mdap create -n slidev
./mdap create -n slidev -l br
./mdap create -n slidev -l cn
./mdap create -n slidev -l de
./mdap create -n slidev -l el
./mdap create -n slidev -l es
./mdap create -n slidev -l fr
./mdap create -n slidev -l ja
./mdap create -n slidev -l ru
./mdap create -n slidev -l vn
```

### Svelte

```
# All docs
./mdap svelte

# Individual doc
./mdap create -n svelte  
./mdap create -n svelte -l ja
```

### Sveltekit

```
# All docs:
./mdap sveltekit

# Individual doc:
./mdap create -n sveltekit 
./mdap create -n sveltekit -l ja
```

### Vite

```
./mdap create -n vite
```

### Vitepress

```
./mdap create -n vitepress
```

### Vitest

```
# All languages
./mdap vitest

# Individual language
./mdap create -n vitest
./mdap create -n vitest -l cn 
```

### Bulletproof-react

```
./mdap create -n bulletproof-react 
```

## Todos

### JS frameworks

- [ ] [Astro guide](https://github.com/withastro/docs/tree/main/src/pages)
- [ ] [11ty](https://github.com/11ty/11ty-website/tree/main/src/docs)
- [ ] [Expressjs](https://github.com/expressjs/expressjs.com)
- [ ] [Gatsby](https://github.com/gatsbyjs/gatsby/tree/master/docs/docs)
- [x] [Nestjs](https://github.com/nestjs/docs.nestjs.com)
- [ ] [Next.js](https://github.com/vercel/next.js/tree/canary/docs)
- [x] [Nuxtjs docs](https://github.com/nuxt/nuxtjs.org/tree/main/content/en/docs)
- [x] React
- [ ] [Remix](https://github.com/remix-run/remix/tree/main/docs/guides)
- [ ] [Solidjs](https://github.com/solidjs/solid-docs/tree/main/langs)
- [x] [Svelte](https://github.com/sveltejs/svelte/tree/master/site/content/docs)
- [x] [SvelteKit](https://github.com/sveltejs/kit/tree/master/documentation)
- [x] [Tauri](https://github.com/tauri-apps/tauri-docs/tree/dev/docs/guides)
- [x] [Vite](https://github.com/vitejs/vite/tree/main/docs/guide)
- [x] [Vitest](https://github.com/vitest-dev/vitest/tree/main/docs)
- [ ] [Vue3 guide](https://github.com/vuejs/docs/tree/main/src/guide)
- [x] [Vuepress guide](https://github.com/vuejs/vitepress/tree/main/docs/guide)


### Static site generator

- [ ] [Jekyll](https://github.com/jekyll/jekyll/tree/master/docs/_docs)

### Tools

- [x] [PNPM](https://github.com/pnpm/pnpm.github.io)
- [x] [Slidev](https://github.com/slidevjs/docs)
- [x] [Shellspec](https://github.com/shellspec/shellspec/tree/master/docs)

### Others

- [x] [bulletproof-react](https://github.com/alan2207/bulletproof-react/tree/master/docs)

### How to make .git small size

```
git clone file:///Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf --depth=1
cd markdown-docs-as-pdf
git remote set-url origin git@github.com:shinokada/markdown-docs-as-pdf.git
git count-objects -v
pnpm i
rm -rf ./.git && git init && git add -A && git commit -m "local clone --depth=1" && git branch -M main && git remote add origin git@github.com:shinokada/markdown-docs-as-pdf.git  && git push origin main --force
```
