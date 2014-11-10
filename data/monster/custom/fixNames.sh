for name in *.xml ./**/*.xml;
do
	newname=$(echo $name | sed -e "s/[0-9]//g" | sed -e "s/ - //g")
	mv "$name" "$newname"
done
