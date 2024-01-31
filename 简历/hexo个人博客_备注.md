## hexo博客

### 一、本地安装客户端
1. 安装客户端：npm install -g hexo-cli
2. 如果是第一次安装：hexo init hexo_blog
3. 安装部署插件：npm install hexo-deployer-git --save
4. 安装主题：
   ```
   // 安装并切换
   1. git submodule add https://github.com/ppoffice/hexo-theme-icarus.git themes/icarus
   2. npm install -S hexo-theme-icarus hexo-renderer-inferno
   3. hexo config theme icarus

   // 卸载
   npm uninstall hexo-theme-icarus

   // clone主题配置到本地 -b指定版本
   git clone https://github.com/ppoffice/hexo-theme-icarus.git themes/icarus -b 5.2.1
   git clone git@github.com:ppoffice/hexo-theme-icarus.git themes/icarus
   ```
5. 客户端根目录：cd /Users/mayu/work_data/hexo_blog
6. 创建新博客文章：hexo new "GCC及开发环境的理解"
7. 打包并发布到远程服务器：hexo c && hexo g && hexo d
8. 历史命令：history | grep hexo

### 二、服务器相关

1. 服务器上涉及博客的文件或文件夹 均需要非 root 的 mayu 用户权限

   ```bash
   chown mayu:mayu /home/hexo/
   chmod +x /home/home/blog.git/hooks/post-receive
   ```

2. 测试连接服务器 然后输入密码 811

   ```bash"ctrl+[Backquote] cmd+x"
   ssh -v mayu@47.108.63.194
   ssh -v mayu@www.mayu1024.com
   ```

3. ICP 备案(暂时未进行公安部备案)

   ```bash
   网站名称: 编程路上的点滴
   4bbf3811-53ee-4a8b-b723-573c77a265ef
   备注：个人在编程学习路上的知识点梳理和记录，方便自己随时
   hexo init hexo_blog
   ```
### 三、本地操作
4. 常用操作命令
   ```bash
   ## 根目录
   cd /Users/mayu/work_data/hexo_blog

   ## 清除、生成、发布连串操作
   hexo c && hexo g && hexo d

   ## 分开执行
   hexo clean
   hexo g
   hexo d

   ## 本地启动
   hexo server

   ## 创建新md
   hexo new "Mac 终端代理的配置.md"
   ```

5. 一些文件夹的作用

   ```bash
   ## 如何删除已经发布的文章: 删除文件夹source/_posts下想要删掉的文章;
   1. 删除文件夹source/_posts下目标文章markdown文件
   2. 删除.deploy_git文件夹
   3. 执行hexo clean后，再执行hexo g，hexo g 即可

   ## /Users/mayu/work_data/hexo_blog/.deploy_git: `.deploy_git` 是git部署用的文件
   1. 在本地在执行hexo g后，会在博客根目录下生成一个public文件夹，这个文件夹里的文件组合起来就是一个完整的静态博客
   2. 接着如果执行hexo d，就会把这个public文件夹的东西完完整整地拷贝到.deploy_git文件夹里，并把该文件夹里的所有文件全部推送push到远程库
   3. 之后会触发Pages服务的钩子去build项目，然后部署到网站上
   4. markdown文章在之前的hexo g之后，把生成的静态文件拷贝到了.deploy_git文件，但hexo clean并没能删除`.deploy_git`里的markdown的静态文件，所以每次部署的时候，它还会冒出来
   ```
