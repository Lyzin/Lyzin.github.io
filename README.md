## 一、创建新笔记

### 1、使用post的layout

```bash
# 在项目根目录下，如下示例
hexo new post -p golang/go_redis使用/go_redis使用
```

> 参数解释：
>
> - `post`:
>     - 表示指定为post的模板
> - -p:
>     -  表示使用自定义路径
> - `golang/go_redis使用/go_redis使用`
>     - 因为post模式layout默认会从`项目根目录的source/_post目录`开始创建新文章，所以新文章的默认路径就是`项目根目录的source/_post`文件夹下
>     - 如果使用自定义目录，只需要写source/_post里的子目录即可
>     - `golang/go_redis使用/go_redis使用`：表示新文章文件的路径是在`项目根目录的source/_post/golang/go_redis使用`目录，并且最后一个`go_redis使用`是新文章的文件名字
>     - 执行完命令以后，会创建和新文章名字一样的文件夹，来存放笔记中的图片

### 2、CDN加速git-page

> 使用 [https://www.cloudflare.com/zh-cn/](https://www.cloudflare.com/zh-cn/) 进行CDN加速

