#!/usr/bin/env bash
poetry new new-django-project
cd ./new-django-project || exit

echo "Copy files..."
FILES=`dirname "$(realpath $0)"`/project_files/
cp -id $FILES/{*,.*} .
echo "Copy files - DONE!"
echo "----------"
echo " "

echo "Copy Dockerfile..."
FILES=`dirname "$(realpath $0)"`/project_files/poetry_dockerfile/
cp -fr "$FILES/Dockerfile" .
echo "Copy files - DONE!"
echo "----------"
echo " "

echo "Copy .gitignore..."
FILES=`dirname "$(realpath $0)"`/project_files/gitignore/
cp -id "$FILES/.gitignore" .
echo "Copy .gitignore - DONE!"
echo "----------"
echo " "

# echo 'Create directory "./code"'
# mkdir ./code
# echo 'Create directory "./code" - DONE!'
# echo "----------"
# echo " "
#
# echo 'Create directory "./data/db"'
# mkdir ./data
# mkdir ./data/db
# echo 'Create directory "./data/db" - DONE!'
# echo "----------"
# echo " "

poetry add django psycopg2-binary environs
poetry add --group dev django-extensions django-debug-toolbar werkzeug
poetry env use python3.12

echo "Update pyproject.toml..."
FILES=`dirname "$(realpath $0)"`/project_files/pyproject/
cat $FILES/pyproject.toml pyproject.toml > tmp_pyproject.toml
rm pyproject.toml
mv tmp_pyproject.toml pyproject.toml
# rm tmp_pyproject.toml
echo "Update pyproject.toml - DONE!"
echo "----------"
echo " "
