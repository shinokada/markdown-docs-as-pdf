parser_definition_framework(){
  setup REST plus:true help:usage abbr:true -- \
        "Usage: ${2##*/} [options...] [arguments...]" ''
    msg -- 'framework' ''
    msg -- 'Options:'
    flag KEEP -k --keep -- "Keep Vivliostyle files"
    flag WEB -w --web -- "Run vivliostyle build -o webpub/ -f webpub without creating PDF"
    disp :usage -h --help
}