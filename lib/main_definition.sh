# shellcheck disable=SC1083
parser_definition() {
    setup REST help:usage abbr:true -- \
        "Usage: ${2##*/} [command] [options...] [arguments...]"
    msg -- '' 'Options:'
    disp :usage -h --help
    disp VERSION --version

    msg -- '' 'Commands: '
    msg -- 'Use command -h for a command help.'
    cmd create -- "Create a PDF doc."
    cmd express -- "Create all Express docs."
    cmd nuxt -- "Create Nuxt PDF docs in en/es/fr/ja/pt-br/pt."
    cmd svelte -- "Creates Svlete PDF docs in en/ja."
    cmd sveltekit -- "Creates SvleteKit PDF docs in en/ja."
    cmd react -- "Create React PDF docs in de/en/fr/he/it/ja/ko/pl/zh-hanz/zh-hant"
    cmd slidev -- "Create Slidev PDF docs in all languages."
    cmd vitest -- "Create Vitest PDF docs in all languages."
    cmd all -- "Create PDF docs for all frameworks."

    msg -- '' "Examples:
    svelte 
    $SCRIPT_NAME svelte
    sveltekit 
    $SCRIPT_NAME sveltekit
    Display the version:
    $SCRIPT_NAME --version
    Display help:
    $SCRIPT_NAME -h | --help
"
}
