find . -name '*.exe' -type f | parallel cp {} ~/bin/'$(basename {} .exe)'.$COMP
