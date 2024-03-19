<p align="center">
<a href='https://ko-fi.com/Z8Z2CHALG' target='_blank'><img height='42' style='border:0px;height:42px;' src='https://storage.ko-fi.com/cdn/kofi3.png?v=3' alt='Buy Me a Coffee at ko-fi.com' /></a>
</p>

# PDF Documentation 

Bash script to create HTML and PDF files for JavaScript Frameworks.

**For the latest docs, please download from [read-and-download-docs.vercel.app](https://read-and-download-docs.codewithshin.com/)**

You can find all the docs in the [pdf directory](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf).

## How to download PDF

Go to a viewer and print as PDF.

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

### Typescript

| Name | Languages | Link |
|--|--|--|
| Typescript | en | [docs](https://github.com/shinokada/markdown-docs-as-pdf/tree/main/pdf/typescript) |

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
# pdf
./mdap create -n nest
# web
./mdap create -n nest -w
```

### Nuxt

```
# Nuxt in all languages
# pdf
./mdap nuxt
# web
./mdap nuxt -w
```

### pnpm

```
# pdf
./mdap create -n pnpm
# web
./mdap create -n pnpm -w
```

### React all docs

```
# All lanugages
# pdf
./mdap react
# web
./mdap react -w

# Individual doc:
# pdf
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

# web
./mdap create -n react -w
./mdap create -n react -w -l de  
./mdap create -n react -w -l fr  
./mdap create -n react -w -l he 
./mdap create -n react -w -l it 
./mdap create -n react -w -l ja 
./mdap create -n react -w -l ko 
./mdap create -n react -w -l pl 
./mdap create -n react -w -l zh-hans 
./mdap create -n react -w -l zh-hant
```

### shellspec

```
# pdf
./mdap create -n shellspec
# web
./mdap create -n shellspec -w
```

### slidev

```
# Slidev in all languages
# pdf
./mdap slidev
# web
./mdap slidev -w

# individual language
# pdf
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

# web
./mdap create -n slidev -w 
./mdap create -n slidev -w -l br
./mdap create -n slidev -w -l cn
./mdap create -n slidev -w -l de
./mdap create -n slidev -w -l el
./mdap create -n slidev -w -l es
./mdap create -n slidev -w -l fr
./mdap create -n slidev -w -l ja
./mdap create -n slidev -w -l ru
./mdap create -n slidev -w -l vn
```

### Svelte

```
# All docs
# pdf
./mdap svelte
# web
./mdap svelte -w

# Individual doc
# pdf
./mdap create -n svelte  
./mdap create -n svelte -l ja

# web
./mdap create -n svelte -w
./mdap create -n svelte -w -l ja
```

### Sveltekit

```
# All docs:
# pdf
./mdap sveltekit
# web
./mdap sveltekit -w


# Individual doc:
# pdf
./mdap create -n sveltekit 
./mdap create -n sveltekit -l ja

# web
./mdap create -n sveltekit -w
./mdap create -n sveltekit -w -l ja
```

### Vite

```
# pdf
./mdap create -n vite

# web
./mdap create -n vite -w
```

### Vitepress

```
# pdf
./mdap create -n vitepress

# web 
./mdap create -n vitepress -w
```

### Vitest

```
# All languages
# pdf
./mdap vitest
# web
./mdap vitest -w

# Individual language
# pdf
./mdap create -n vitest
./mdap create -n vitest -l cn 

# web
./mdap create -n vitest -w
./mdap create -n vitest -w -l cn 
```

### Bulletproof-react

```
# pdf
./mdap create -n bulletproof-react

# web
./mdap create -n bulletproof-react -w
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

## How to use this script

### Requirements:

```
brew install poppler
brew install calibre
npm install -g @vivliostyle/cli
npm install html-minifier -g
```

### Clone read-html-download-pdf:

```
git clone git@github.com:shinokada/read-html-download-pdf.git
```

### Update files

Change the `WEBAPP` path in `mdap`:

```
WEBDIR="/Users/shinichiokada/Vivliostyle/read-doc-download-pdf/"
APPDIR="docs/frameworks"
```