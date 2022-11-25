get_svelte_title() {
  file=$1
  # 1. Remove --- # 2. change title: to #, 3. change ### to ## or #### to ###
  sed -i -e 's/---//' \
  -e 's/title:/#/' \
  -e 's/###/##/' "${file}"
}

fix_svelte_link(){
  file=$1
  # [attributes and props](/docs#template-syntax-attributes-and-props) to
  # [attributes and props](#template-syntax-attributes-and-props)
  # /docs#template-syntax-attributes-and-props to ./template-syntax-attributes-and-props.html
  sed -i -e 's|/docs#introduction|00-introduction.html|g' \
  -e 's|/docs#getting-started|01-getting-started.html|g' \
  -e 's|/docs#component-format|02-component-format.html|g' \
  -e 's|/docs#template-syntax-attributes-and-props|03-template-syntax.html|g' \
  -e 's|/docs#template-syntax-component-directives-bind-this|03-template-syntax.html|g' \
  -e 's|/docs#compile-time-svelte-compile|05-compile-time.html|g' \
  -e 's|/docs#run-time-client-side-component-api|04-run-time.html|g' \
  -e 's|/docs#template-syntax-each|03-template-syntax.html|g' \
  -e 's|/docs#run-time-svelte-animate|04-run-time.html|g' \
  -e's|/docs#template-syntax-element-directives-animate-fn-custom-animation-functions|03-template-syntax.html|g' \
  -e 's|/docs#run-time-svelte-createeventdispatcher|04-run-time.html|g' \
  -e 's|/docs#template-syntax-element-directives-use-action|03-template-syntax.html|g' \
  -e 's|(/docs#compile-time-svelte-compile|05-compile-time.html|g' \
  -e 's|/docs#template-syntax-slot-slot-name-name|03-template-syntax.html|g' \
  -e 's|/docs#run-time-server-side-component-api|04-run-time.html|g' \
  -e 's|/docs#template-syntax-component-directives-on-eventname|03-template-syntax.html|g' \
  -e 's|/docs#run-time-svelte-store-readable|04-run-time.html|g' \
  -e 's|/docs#run-time-svelte-store-derived|04-run-time.html|g' \
  -e 's|/docs#run-time-svelte-store-writable|04-run-time.html|g' \
  -e 's|/docs#run-time-svelte-store|04-run-time.html|g' \
  -e 's|/docs#component-format-script-4-prefix-stores-with-$-to-access-their-values|02-component-format.html|g' \
  -e 's|/docs#component-format-script-4-prefix-stores-with-$-to-access-their-values-store-contract|02-component-format.html|g' \
  -e 's|/docs#run-time-svelte-easing|04-run-time.html|g' \
  -e 's|/docs#run-time-svelte-motion-tweened|04-run-time.html|g' \
  -e 's|/docs#template-syntax-element-directives-transition-fn|03-template-syntax.html|g' \
  -e 's|/docs#template-syntax-svelte-options|03-template-syntax.html|g' \
  -e 's|/docs#run-time-svelte-register|04-run-time.html|g' $file
}

clean_svelte(){
  file=$1
  fix_link "$file"
  fix_svelte_link "$file"
}

