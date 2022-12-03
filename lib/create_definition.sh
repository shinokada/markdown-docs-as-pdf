parser_definition_create() {
    setup REST plus:true help:usage abbr:true -- \
        "Usage: ${2##*/} [options...] [arguments...]" ''
    msg -- 'create command' ''
    msg -- 'Options:'
    flag KEEP -k --keep -- "Keep Vivliostyle files"
    flag WEB -w --web -- "Run vivliostyle build -o webpub/ -f webpub without creating PDF"
    flag PREVIEW -p --preview -- "Run npm run preview to preview on a browser"
    flag COVER -c --cover -- "Add cover page"
    param LANG -l --lang init:="en" -- "Language default is en. es, de, fr, ja, ko, etc."
    param NAME -n --name -- "Name react, svelte"
    param ONE -o --one -- "Number of layer is one"
    param ONE -t --two -- "Number of layer is two"
    param URL -u --url -- "GitHub url for docs"
    param NUMSTRUCTURE -s --numstr -- "Layer number of directory, 1, 2, 3"
    param PAPERSIZE -p --papersize init:='A4' -- "Paper size"
    disp :usage -h --help
}
