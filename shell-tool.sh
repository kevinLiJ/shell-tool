#!/bin/bash
# 进入后台项目 静态资源目录 =======
cd ./background-project/web/src/main/resources/static/
# 获取当前分支 =======
branch=$(git symbolic-ref --short HEAD)

# 拉去当前分支最新代码 =======
git pull origin "$branch"
echo -e "\n\nbackground-project项目当前的分支为:   $branch"

read -p $'\n\n请确认分支，是否继续操作？y or n: ' isContinue
if [ "$isContinue" != 'y' ];then 
    exit
fi

# 替换文件 =======
# 删除旧的打包资源
rm -r ./static
rm index.html
# 复制新的打包资源到后台目录下
cp -r ../../../../../../fe-project/dist/* ./
git status
read -p $'\n\n已替换文件成功，是否继续提交操作？y or n: ' isContinueSubmit
if [ "$isContinueSubmit" != 'y' ];then 
    git reset --hard ^HEAD
    exit
fi

# git提交 =======
git add .
read -p $'\n\n请输入您的commit信息： ' commitInfo
git commit -m ${commitInfo}
git push origin ${branch}
