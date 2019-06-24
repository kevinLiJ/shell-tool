
## 背景
> 有一些前端项目，没有独立的的各环境部署流程，需要依附后台项目的静态服务来一同部署，这种情况下，前端同学提交一次代码将会是很繁杂的操作
> 1. 修改代码
> 2. 打包项目
> 3. 前端项目git提交
> 4. 拉取后台项目最新代码
> 5. 删除后台项目的静态服务目录下，旧的前端打包资源
> 6. 把新的前端资源复制到静态服务目录下
> 7. 后台项目git提交
> 
> 一次两次的上线还可容忍，但测试阶段，修改bug时，就需要不停重复上述流程，来部署测试环境。忍无可忍，无须再忍。。。

## 使用`shell`脚本组合这一系列的操作，省时省力

```sh
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

```
[项目地址](https://github.com/kevinLiJ/shell-tool)
#### 使用
+ 本人把`shell`文件放在了与前后端项目同级的目录下。也可以把它放在后端项目的静态目录下，记得把它添加进`.gitignore`避免提交就可以了。
+ 自行修改**前端项目打包资源路径**、**后端项目静态资源目录路径**
+ `git bash(windows`)或终端`(linux)`中进入`shell`文件目录下，使用`sh`命令即可执行`shell`文件：`sh ./shell-tool.sh`。

#### 难度不大，仅仅是一些`shell`命令和`git`命令的堆砌，但也学了一些东西
+ `echo -e`可以识别转义字符。可以在输出时加入换行符 `echo -e '\n hello world'`实现换行
+ 使用`$''`形式的字符串，可以在`read`命令中使提示语换行。[see here](http://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#ANSI_002dC-Quoting)
+ [`read`命令](https://www.runoob.com/linux/linux-comm-read.html)
+ `git`获取当前项目分支
    +  `branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')`
    +  [see here](https://stackoverflow.com/questions/6245570/how-to-get-the-current-branch-name-in-git)

