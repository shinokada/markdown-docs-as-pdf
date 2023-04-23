clean_deta(){
  file=$1
  # remove <div style={{textAlign: 'center'}}>
	#   <img src=/img/domains/custom_domain.png alt=custom_domain width=600/>
  # </div>
  # sed -i '/textAlign/d' $file
  # sed -i '/img/d' $file
  # sed -i '/<\/div>/d' $file
  sed -i 's/<mailto:aavash@deta.sh?subject=Re-enable custom domain>//' $file
  sed -E '/title:/{s/[^ ]* (.*)/\1/;h};/^-/,/^}/d;/^$/{x;s/^/# /;G}' $file
  # sed -i 's/^---.*^title:\s*([^\n]+\n).*(?=## General)/# $1/ms' $file
}