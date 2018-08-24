# 将本地项目提交到github流程
1.打开终端 cd 到项目工程所在目录
2.git init (初始化git 仓库)
3.git add .
4.git commit -m"提交说明"
5.git remote add origin https://github.com/applekwork/xxx(工程名字).git
`**fatal: remote origin already exists.(远程已存在)需要删除重新添加 
**`
git remote rm origin
6.git push -u -origin master （第一次提交需加 -u）
`**fatal: refusing to merge unrelated histories 错误**`
git merge --allow -unrelated histories
git pull origin master --allow -unrelated-histories
git push -u origin master

git修改当前的project提交邮箱的命令为：git config  --global user.name 你的目标用户名

       





