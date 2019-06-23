# 获取当前分支
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
echo '您当前的分支为$branch'
read -p '是否确认继续操作？y or n' isContinue
if [ -z $isContinue ];then 
   exit
else
cp -r ../前段知识总结 ./
git add .
read -p '请输入您的commit信息： ' commitInfo
git commit -am ${commitInfo}
git push origin ${branch}
