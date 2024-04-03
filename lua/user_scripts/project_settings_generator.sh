#!/bin/bash

echo "Copy files..."
FILES=`dirname "$(realpath $0)"`/project_files/
cp -id $FILES/{*,.*} .
echo "Copy files - DONE!"
echo "----------"
echo " "

echo "Copy .gitignore..."
FILES=`dirname "$(realpath $0)"`/project_files/gitignore/
cp -id $FILES/{*,.*} .
echo "Copy .gitignore - DONE!"
echo "----------"
echo " "

echo 'Create directory "./code"'
mkdir ./code
echo 'Create directory "./code" - DONE!'
echo "----------"
echo " "

echo 'Create directory "./data/db"'
mkdir ./data
mkdir ./data/db
echo 'Create directory "./data/db" - DONE!'
echo "----------"
echo " "

echo "Create venv..."
python3 -m venv venv
echo "Create venv - DONE!"
echo "----------"
echo " "

echo "Install Django..."
venv/bin/python -m pip install django
echo "Install Django - DONE!"
echo "----------"
echo " "

echo "Install psycopg2..."
venv/bin/python -m pip install psycopg2-binary
echo "Install dpsycopg2 - DONE!"
echo "----------"
echo " "

echo "Create requirements.txt..."
venv/bin/python -m pip freeze > requirements.txt
echo "Create requirements.txt - DONE!"
echo "----------"
echo " "

echo "WORK DONE!"
