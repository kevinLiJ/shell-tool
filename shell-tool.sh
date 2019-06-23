branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
# cp -r ../前端知识总结 ./
git add .
git commit -am init
git push origin ${branch}
