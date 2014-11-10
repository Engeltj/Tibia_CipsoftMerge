for name in ./
do
	newname="$(echo "$name" | cut -c7-)""$(echo "$name" | cut -c7-)"
	mv "$name" "$newname"
done
