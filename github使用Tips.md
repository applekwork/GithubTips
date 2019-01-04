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
# git修改当前的project提交邮箱的命令为
git config  --global user.name 你的目标用户名
# 服务器上的 Git - 生成 SSH 公钥
[https://git-scm.com/book/zh/v2/服务器上的-Git-生成-SSH-公钥]()
如前所述，许多 Git 服务器都使用 SSH 公钥进行认证。 为了向 Git 服务器提供 SSH 公钥，如果某系统用户尚未拥有密钥，必须事先为其生成一份。 这个过程在所有操作系统上都是相似的。 首先，你需要确认自己是否已经拥有密钥。 默认情况下，用户的 SSH 密钥存储在其 ~/.ssh 目录下。 进入该目录并列出其中内容，你便可以快速确认自己是否已拥有密钥：

$ cd ~/.ssh
$ ls
authorized_keys2  id_dsa       known_hosts
config            id_dsa.pub
我们需要寻找一对以 id_dsa 或 id_rsa 命名的文件，其中一个带有 .pub 扩展名。 .pub 文件是你的公钥，另一个则是私钥。 如果找不到这样的文件（或者根本没有 .ssh 目录），你可以通过运行 ssh-keygen 程序来创建它们。在 Linux/Mac 系统中，ssh-keygen 随 SSH 软件包提供；在 Windows 上，该程序包含于 MSysGit 软件包中。

$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/schacon/.ssh/id_rsa):
Created directory '/home/schacon/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/schacon/.ssh/id_rsa.
Your public key has been saved in /home/schacon/.ssh/id_rsa.pub.
The key fingerprint is:
d0:82:24:8e:d7:f1:bb:9b:33:53:96:93:49:da:9b:e3 schacon@mylaptop.local
首先 ssh-keygen 会确认密钥的存储位置（默认是 .ssh/id_rsa），然后它会要求你输入两次密钥口令。如果你不想在使用密钥时输入口令，将其留空即可。

现在，进行了上述操作的用户需要将各自的公钥发送给任意一个 Git 服务器管理员（假设服务器正在使用基于公钥的 SSH 验证设置）。 他们所要做的就是复制各自的 .pub 文件内容，并将其通过邮件发送。 公钥看起来是这样的：

$ cat ~/.ssh/id_rsa.pub
ssh-rsa xxxx
关于在多种操作系统中生成 SSH 密钥的更深入教程，请参阅 GitHub 的 SSH 密钥指南 
[https://help.github.com/articles/generating-ssh-keys。]()
# git 提交错误解决办法
 场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令
` git checkout -- file`
“--”很重要，没有“--”，就变成了“切换到另一个分支”的命令，我们在后面的分支管理中会再次遇到git checkout命令

场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令`git reset HEAD file`，就回到了场景1，第二步按场景1操作。

场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节， 不过前提是没有推送到远程库。git reset --hard ，HEAD表示当前版本，上一个版本就是HEAD^，上上一个版本就是HEAD^^
`git reset --hard HEAD^`
git reset --hard commit_id (版本号)

git merge --no-ff -m "merge with no-ff" dev

# git 暂时封存代码
git stash save "test-cmd-stash" //增加注释

git stash list

git stash pop //这个指令将缓存堆栈中的第一个stash删除，并将对应修改应用到当前的工作目录下

git stash apply //将缓存堆栈中的stash多次应用到工作目录中，但并不删除stash拷贝

在使用git stash apply命令时可以通过名字指定使用哪个stash，默认使用最近的stash（即stash@{0}）
# 创建Cocoapods的podspec
1.github上创建自己的共有项目
2.创建自己的Xcode工程，并提交到该repository
git tag '1.0.0‘
git push --tags
3.创建podspec文件
pod spec create xxxx(spec文件名) git@github.com:xx/xx.git 

4.执行如下命令进行校验.spec文件的正确性
pod lib lint
 
备注：这个命令是本地校验的，还要pod spec lint 这个是本地和远程校验。如果此时我们用pod spec lint会报错，因为我们还没有发布一个版本，就是第6步还没做呢。

到这步整个制作过程已经完成接下来让我们发布自己spec
CocoaPods 0.33中加入了 Trunk 服务，使用 Trunk 服务可以方便的发布自己的Pod。要想使用 Trunk 服务，首先需要使用如下命令注册自己的电脑。这很简单，只要你指明你的邮箱地址（spec文件中的）和名称即可。CocoaPods 会给你填写的邮箱发送验证邮件，点击邮件中的链接就可通过验证。

github上创建一个发布版本

5.pod trunk register applekwork@163.com 'guo' --verbose

6.验证是否注册成功
pod trunk me

7.发布我们的podspec
pod trunk push

不过此时我们pod search还搜不到我们的podspec。

可以通过一下两步之后再尝试搜索:

运行pod setup更新本地的spec，再搜索一下试试看。
删除~/Library/Caches/CocoaPods目录下的search_index.json文件
pod setup成功后会生成~/Library/Caches/CocoaPods/search_index.json文件。
终端输入rm ~/Library/Caches/CocoaPods/search_index.json
删除成功后再执行pod search

`.spec文件：
Pod::Spec.new do |s|
s.name         = 'guolib'
s.version      = '1.0.0'
s.summary      = 'test测试'
s.homepage     = 'https://github.com/applekwork/guolib'
s.license      = 'MIT'
s.authors      = {'guo' => 'applekwork@163.com'}
s.platform     = :ios, '9.0'
s.source       = {:git => 'https://github.com/applekwork/guolib.git', :tag => s.version}
s.source_files = 'guolib/**/*.{h,m}'
s.requires_arc = true
end

`


