#!/bin/bash

build_documentation () {
   export current_version
   git checkout ${current_version}
   cp -f /tmp/conf.py conf.py

   echo "Building documentation for ${current_version}..."

   if [ -f 'templates/versions.html' ]; then
     mkdir -p templates
     cp -f /tmp/versions.html templates/versions.html
     sphinx-build . build/html/${current_version}
     rm -rf templates
   else
     mkdir -p templates
     cp -f /tmp/versions.html templates/versions.html
     sphinx-build . build/html/${current_version}
     git checkout -- templates/versions.html
   fi
   git checkout -- conf.py
}

current_version="v9.1"
export versions="master v9.1 v9.0"

cp -f conf.py /tmp/conf.py
cp -f templates/versions.html /tmp/versions.html

build_documentation
for current_version in ${versions}; do
  build_documentation
done
