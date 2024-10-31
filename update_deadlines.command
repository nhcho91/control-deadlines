#!/bin/sh
# explicit setting of script execution directory
cd -- "$(dirname -- "$BASH_SOURCE")"
echo "\n"

# Build site
echo "data ----> site\n"
bundle exec jekyll build --future -d _site/control-deadlines

# Test build result
echo "site ----> htmlproofer\n"
# bundle exec htmlproofer ./_site --only-4xx --check-favicon --check-html
bundle exec htmlproofer ./_site --only-4xx

# Update .ics Calendar file
echo "data ----> ics\n"
cp _site/control-deadlines/control-deadlines.ics _data/

# Sort conference list
python3 utils/process.py

# local -> git repo
echo "\nlocal dir ----> git repo"
git add --all
git commit -m "housekeeping shell script"
git push origin master 
git status
