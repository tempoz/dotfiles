#README
-------

These are my Linux configuration files, mainly provided here for my own use/reference.


#Setup
------

```
sudo apt-get update
sudo apt-get install python3-dev clang make man curl powerline git-lfs 7zip libgtk-3-dev vim-gtk3 liblua5.4-dev lua5.4 tig

# if WSL, also:
sudo apt-key del 7fa2af80
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get install libxcursor-dev libxinerama1 cuda
```

Gotta build vim (newer than 8.2), do it with these configuration flags:
```
./configure --enable-multibyte --enable-rubyinterp --enable-python3interp --with-python3-config-dir=(python3-config --configdir) --enable-perlinterp --enable-luainterp --disable-pythoninterp --disable-mzschemeinterp --enable-tclinterp --with-tclsh=/usr/bin/tclsh --with-features=huge --prefix=/usr/ --enable-cscope --disable-gui --enable-autoservername='yes' --enable-gui=gtk3
```

Get vim-plug.

Run `:PlugInstall` in vim.

Need the italics-enabled terminfo, run:
```
tic xterm-256color-italic.terminfo
```
