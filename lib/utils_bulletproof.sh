clean_bulletproof(){
  file=$1
  # change ../src/ to https://github.com/alan2207/bulletproof-react/tree/master/src/
  sed -i 's|../src/|https://github.com/alan2207/bulletproof-react/tree/master/src/|' $file
  # change [here](./style-guide.md) to [here](./style-guide.html)
  sed -i 's|.md)|.html)|' $file
}