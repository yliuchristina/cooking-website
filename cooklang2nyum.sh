#!/bin/bash
pipenv install
echo "Setting up recipes"
echo "slugify the jpg and mv them in case cooklang parser not do so"
rm -rf _temp _recipes
mkdir -p _temp _recipes
mv cooklang_recipes/README.cook _temp
for i in `ls cooklang_recipes | grep -v .cook`; do

  filename=$(basename -- "$i")
  extension="${filename##*.}"
  filename="${filename%.*}"

  cp -v cooklang_recipes/$i _recipes/`pipenv run slugify $filename`.$extension
done

pipenv run python -m cooklang to-nyum cooklang_recipes _recipes
mv _temp/README.cook cooklang_recipes
ls -l _recipes
