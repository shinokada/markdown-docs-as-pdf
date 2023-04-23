fix_sveltekit_link(){
  file=$1
  # e.g. change [project config](/docs/configuration) to [project config](../50-api-reference/10-configuration.html)
  # method 1
  # 1. from filenames1 find the line with configuration from [project config](/docs/configuration)
  # get the last word
  # 2. then find parent dir that contains configuration
  # 3. "/Users/shinichiokada/Bash_Projects/markdown-docs-as-pdf/.vivliostyle/sveltekit/en/docs/50-api-reference/10-configuration.md",
  # 4. to [project config](../50-api-reference/10-configuration.html)
  # method 2
  sed -i -e 's|/docs/introduction|../10-getting-started/10-introduction.html|g' \
  -e 's|/docs/creating-a-project|../10-getting-started/20-creating-a-project.html|g' \
  -e 's|/docs/project-structure|../10-getting-started/30-project-structure.html|g' \
  -e 's|/docs/web-standards|../10-getting-started/40-web-standards.html|g' \
  -e 's|/docs/routing|../20-core-concepts/10-routing.html|g' \
  -e 's|/docs/load|../20-core-concepts/20-load.html|g' \
  -e 's|/docs/form-actions|../20-core-concepts/30-form-actions.html|g' \
  -e 's|/docs/page-options|../20-core-concepts/40-page-options.html|g' \
  -e 's|/docs/adapters|../20-core-concepts/50-adapters.html|g' \
  -e 's|/docs/advanced|../30-advanced/10-advanced-routing.html|g' \
  -e 's|/docs/hooks|../30-advanced/20-hooks.html|g' \
  -e 's|/docs/advanced|../30-advanced/25-errors.html|g' \
  -e 's|/docs/service-workers|../30-advanced/40-service-workers.html|g' \
  -e 's|/docs/server-only-modules|../30-advanced/50-server-only-modules.html|g' \
  -e 's|/docs/assets|../30-advanced/60-assets.html|g' \
  -e 's|/docs/packaging|../30-advanced/70-packaging.html|g' $file

  sed -i 's|/docs/seo|../40-best-practices/20-seo.html|g' $file
  sed -i 's|/docs/configuration|../50-api-reference/10-configuration.html|g' $file
  sed -i 's|/docs/cli|../50-api-reference/20-cli.html|g' $file
  sed -i 's|/docs/modules|../50-api-reference/30-modules.html|g' $file
  sed -i 's|/docs/types|../50-api-reference/40-types.html|g' $file
  sed -i 's|/docs/migration|../60-appendix/10-migration.html|g' $file
  sed -i 's|/docs/additional-resources|../60-appendix/20-additional-resources.html|g' $file
  sed -i 's|/docs/glossary|../60-appendix/30-glossary.html|g' $file
  sed -i 's|/docs/link-options|../30-advanced/30-link-options.html|g' $file
  sed -i 's|/docs/accessibility|../40-best-practices/10-accessibility.html|g'  $file
}

clean_sveltekit(){
  file=$1
  remove_slash_docs "$file"
  fix_sveltekit_link "$file"
}

fn_move_sveltekit(){
  bannerColor "Removing old files and dirs from ${WEBAPP}/${NAME}/${LANG} ..." "blue" "*"
  # remove the old dir
  rm -Rf ${WEBAPP}/${NAME}/${LANG}
  # create a new dir
  mkdir -p ${WEBAPP}/${NAME}/${LANG} 
  bannerColor "Removed old files and dir." "green" "*"

  bannerColor "Removing all non-HTML files from ${WORKSPACE} ..." "blue" "*"
  find ${WORKSPACE} -type f -not -name '*.html' -delete
  bannerColor "Successfully removed non-HTML files." "green" "*"

  bannerColor "Minifying HTML files and outputting to ${WEBAPP}/${NAME}/${LANG}." "blue" "*"
  # minify to ${WEBAPP}/${NAME}/${LANG}
  html-minifier  --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --minify-css true --minify-js true --input-dir ${WORKSPACE} --output-dir ${WEBAPP}/${NAME}/${LANG}
  bannerColor "Successfully minified and moved." "green" "*"
}