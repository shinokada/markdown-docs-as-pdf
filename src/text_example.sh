fn_text() {
    # color check
    blackprint "Testing black print."
    blueprint "Testing blue print."
    cyanprint "Testing cyan print."
    defaultprint "Testing default print."
    greenprint "Testing green print."
    magentaprint "Testing magenta print."
    redprint "Testing red print."
    whiteprint "Testing white print."
    yellowprint "Testing yellow print."

    boldprint "$(yellowprint "Bold and yellow print.")"
    italicprint "$(redprint "Italic and red print.")"
    swapprint "$(blueprint "Swap and blue print.")"
    strikeprint "$(greenprint "Strike-through and green print.")"

    bannerColor 'bannerColor example blue and *' "blue" "*"
    bannerSimple 'bannerSimple' "*"
    bannerColor 'bannerColor example green and =' 'green' '='
}
