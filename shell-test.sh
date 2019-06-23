branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo ${branch}
