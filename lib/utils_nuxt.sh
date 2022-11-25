clean_nuxt(){
  sed -i -e 's/::code-group//g' \
  -e 's/::alert{type="info"}/#### Info/g' \
  -e 's/::alert{type="warning"}/#### Warning/g' \
  -e 's/::alert{type="next"}/#### Next/g' \
  -e 's/:://g' "${file}"
  # sed -i 's/::/<\/block>/g' "${file}"
}

