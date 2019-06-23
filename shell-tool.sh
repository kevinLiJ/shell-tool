branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
cp -r ../前段知识总结 ./
git add .
read -p '请输入您的commit信息' commitInfo
git commit -am ${commitInfo}
git push origin ${branch}
