# 说明

从https://github.com/Martins3/My-Linux-Config fork而来，只留下了nvim的配置部分。

这个工程是用于windows版本的nvim配置。

## 变更说明

- 注释掉`vim/misc.vim`中的`autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif`一句。该句会导致打开目录时nvim直接退出。

- `lua\usr\nvim-tree.lua`按照插件更新的要求重新生成。

- `lua\usr\which-key.lua`中注释掉`<tab>`的映射，否则按下`Ctrl+i`时会自动触发`<TAB>`键的功能。

- `vim\coc.vim`中注释掉`w`和`b`的映射，否则`w`和`b`无法正确响应前导数字。

## 安装过程

参考文档[Windows系统下neovim的安装和简易配置](https://zhuanlan.zhihu.com/p/432823659)

这里补充一下其他的项

### libfzf.dll找不到

需要用choco安装mingw和make, 重新安装`telescope-fzf-native`插件或者直接去插件目录执行`make`。

### powershell下的代理设置

`$env:HTTPS_PROXY="http://127.0.0.1:8889"`
