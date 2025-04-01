# 1. 密码管理：
建议使用ssh方式，这样可以方便的管理，不过在自己的电脑上，采用https更加稳定方便（方便代理），可以在本地的配置文件中随时修改远程仓库的地址，切换两种方法。
## 1.1. https方法：
最为简单，但是不安全，因为可能登录凭证会被保存在目标计算机上，只能通过修改密码的方式或者手动去电脑上删除凭证和缓存，仅仅删除凭证还不够，因为浏览器可能还登录了。
如果使用了https认证，电脑需要连接浏览器进行认证，如果后续不想在电脑上保留，则可以通过以下方式删除认证：
Windows：可以通过“控制面板” -> “用户账户” -> “凭据管理器”来打开凭据管理器。
MacOS系统中，可以通过“系统偏好设置” -> “用户与群组” -> “操作” -> “凭证管理器”来打开凭证管理器
清除本机缓存：有时候，git账号信息可能会被本机缓存下来，因此退出git账号后仍然可以进行操作。为了完全退出git账号，可以清除本机的缓存。在命令行中执行`git credential-manager reject `命令，将缓存的git账号信息进行拒绝，并清除缓存。
## 1.2. SSH方法：
1. 通过命令 `ssh-keygen` 生成 SSH Key，其中-t ed25519是密钥方法，旧系统可能要其他方法，-C是注释
	```bash
	ssh-keygen -t ed25519 -C "Gitee SSH Key"
	```
2. 查看生成的 SSH 公钥和私钥：输出的id_ed25519为私钥文件，id_ed25519.pub为公钥文件
	```bash
	ls ~/.ssh/
	```
3. 读取公钥文件 `~/.ssh/id_ed25519.pub`：也可以直接在路径中打开这个文件。
	```bash
	cat ~/.ssh/id_ed25519.pub
	```
注意：如果在用ssh时，提示指纹认证相关的问题，可以按ESC退出，在系统终端输入以下测试代码，信任其指纹即可
```bash
ssh -T git@github.com #forGitHub
ssh -T git@gitee.com #forgitee
```
# 2. 代理：
## 2.1. https:代理
使用国内的代码仓库应该没问题，使用GitHub有时可能会很慢或者连不上，需要设置代理：
修改全局配置文件〜/.gitconfig
```
[http]
    proxy = 127.0.0.1:7890
[https]
    proxy = 127.0.0.1:7890
```
或者通过命令行：
```bash
git config --global https.proxy http://127.0.0.1:7890
git config --global https.proxy https://127.0.0.1:7890
#取消：
git config --global --unset http.proxy
git config --global --unset https.proxy
```
## 2.2. ssh代理：
为 SSH 设置代理,一般并不需要，如果遇到因防火墙ssh同步GitHub不行时，可以试试走代理
为 Git 以 ssh 的方式拉取项目设置代理的实质, 其实就是为 ssh config 中的 github.com 设置代理, 那么说到为ssh设置代理, 自然绕不开 ~/.ssh/config,

我们需要在 ~/.ssh/config 中加入如下内容:
```
Host github.com
  Hostname ssh.github.com
  Port 443
  User git
  ProxyCommand "D:\Program Files\Git\mingw64\bin\connect.exe" -H 127.0.0.1:7890 %h %p
# 如果不断提示手动确认指纹，则可以通过增加以下代码：StrictHostKeyChecking no # 跳过主机密钥验证
# 这样可能会具有风险，经过测试，可以先用下面的测试连接（ssh -T git@github.com）先将指纹添加进名单
# 这样再github同步即可完成。
```
接着尝试用 git 用户 SSH 连接 Github.com
```bash
ssh -T git@github.com
ssh -T git@gitee.com #forgitee
# 如果输出以下内容则代表成功.
Hi ***! You've successfully authenticated, but GitHub does not provide shell access.
```
# 3. 常规操作：
1. 克隆或者初始化本地仓库，分别为git clone [url]  与 git init
2. 当仓库初始化后，修改了一些代码文件，此时会有一些待暂存的文件，可以暂存或者忽略，当然也可以丢弃（会将对应文件还原回上次提交状态），使用add命令或者其他命令，最后提交这些认为已经成熟的文件，使用commit命令，在可视化软件中可以很容易做到，commit时要输入提交信息
3. 提交改动后，对于本地仓库就已经结束了，可以将其push到远程仓库
4. 如果想要查看历史提交节点的状态，可以用检出进行（临时），或者创建分支（在之前基础上继续工作），具体操作见下文。
# 4. 取消文件跟踪
对某个文件取消跟踪
git rm --cached readme1.txt    删除readme1.txt的跟踪，并保留在本地。
git rm --f readme1.txt    删除readme1.txt的跟踪，并且删除本地文件。
一般用第一个就行，第二个会删除本地的该文件，该文件就没有了，只能通过git恢复回来了，慎用！
# 5. 分支和检出（已分离）
可以对历史节点或者当前节点选择创建新的分支，进行另一个版本线的开发，但是如果只是临时查看测试某个节点的版本，则可以使用头部分离的方式，在vscode中选择某个提交节点，右键检出（已分离）即可完成，此时也可以进行修改，提交，但是此时只是临时的，如果不保存建立分支，则切换分支后，所有提交都会消失；如果进行了修改，并提交了，会得到一个临时的 commit-hash id，此时需要在菜单栏进行分支创建，如下图左侧的图像中右键出代表的是从这里临时检出的，其id还是那时的，而最新的提交临时id已经变了（左下角id已经不是b845d81了），通过上面菜单栏进行分支创建，则会对当前工作的最新提交进行创建分支，也可以通过命令行进行创建。
![[Pasted image 20250330203719.png]]
创建完成分支后，如果想要发布到远程仓库，可以推送该分支，同时远程仓库要处理
```bash
git checkout main # 可以切换到某个分支的最新提交 
git checkout <commit-hash>  # 可以切换到某个提交，但是此时处于指针头部分离状态，需要创建分支才能保存提交
```
需要保存时，可以：
```bash
git branch <new-branch-name> <commit-hash>  # 将游离提交绑定到新分支，注意此处的<commit-hash>是最新提交的临时id
git log -n 1 # 可以通过该命令查询当前提交的id，当然此方法适用于对任意历史提交创建分支，当然如果当前指针已经在这个id，一般也可以省略<commit-hash>，直接创建分支即可
git checkout <new-branch-name>        # 切换到新分支继续工作
# 或者合并为下面一行命令
git checkout -b <new-branch-name>     # 直接创建并切换到新分支‌
```
当远程分支发生变动，比如删除或其他人push了新分支，可以通过以下命令进行更新，此操作或更新所有远程仓库分支
```bash
git remote update origin --prune # 同步远程分支信息并清理无效分支
#‌ 或者以下命令
git fetch -p # 自动修剪（prune）远程已删除的分支记录‌
```
如果想拉取远程新的分支，可以在vscode中选择抓取（fetch）操作，但是不会修建无效分支
如果只是想更新某个分支：
```bash
# 1.拉取特定远程分支：
git fetch origin <新分支名>
‌# 2.基于远程分支创建本地分支：
git checkout -b <本地分支名> origin/<远程分支名>
```

# 6. Tag
可以选择某个提交节点增加标签，如果让本地的标签推送到远程，需要使用命令实现：
```bash
git push --tags
```
# 7. Pull Request
当本地推送了某个新的分支到远程仓库，会引发一个PR请求，此时可以在远程将新分支合并到其他分支中去，当然也可以不用理会
# 8. 分支 变基-合并
建议采用变基-合并操作将一些临时修复任务合到主支中，将分支2变基到主分支上，相对于在主分支基础上将分支2的修改按顺序添加到主分支后面，再切换到原来主分支，合并分支2即可实现主分支的单线程推进，此时再将主分支推送到远程，就不会有分叉了；
而如果不使用变基，直接在主分支合并分支2，则会产出分叉记录，即使删除了分支2，也会保留分叉，如下所示，前面采用变基-合并操作，发现提交记录是串行的，而最后采用合并，会产生一个分叉，即使分叉又合并回来了，但是不够线性；
但是，如果主分支没有继续往前推进，而是在分支2上进行推进，成熟后，则可以直接在主分支合并分支2，此时主分支直接沿着分支2快速推进到分支2最新提交。
![[Pasted image 20250330224852.png]]
