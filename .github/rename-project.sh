#!/usr/bin/env bash
while getopts a:n:u:d: flag
do
    case "${flag}" in
        a) author=${OPTARG};;
        n) name=${OPTARG};;
        u) urlname=${OPTARG};;
        d) description=${OPTARG};;
    esac
done

echo "Author: $author";
echo "Project Name: $name";
echo "Project URL name: $urlname";
echo "Description: $description";

echo "Renaming project..."

original_author="author_name"
original_name="project_name"
original_urlname="project_urlname"
original_description="project_description"
original_name_upper="$(echo $original_name|tr 'a-z' 'A-Z')"
name_upper="$(echo $name|tr 'a-z' 'A-Z')"

# for filename in $(find . -name "*.*")
for filename in $(git ls-files)
do
    sed -i "s/$original_author/$author/g" $filename
    sed "s/$original_name/$name/g" $filename
    sed -i "s/$original_urlname/$urlname/g" $filename
    sed -i "s/$original_description/$description/g" $filename
    sed "s/$original_name/$name/g" $filename
    sed "s/$original_name_upper/$name_upper/g" $filename
    echo "Renamed $filename"
done

mv cmd/app cmd/$name
mv pkg/app/app.go pkg/app/$name.go
mv pkg/app pkg/$name

# This command runs only once on GHA!
rm -rf .github/template.yml