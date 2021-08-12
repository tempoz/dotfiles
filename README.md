#README
-------

These are my Linux configuration files, mainly provided here for my own use/reference.


#Setup
------

Gotta build vim (newer than 8.2), do it with these configuration flags:
```
./configure --enable-multibyte --enable-rubyinterp --enable-python3interp --with-python3-config-dir=(python3-config --configdir) --enable-perlinterp --enable-luainterp --disable-pythoninterp --disable-mzschemeinterp --enable-tclinterp --with-tclsh=/usr/bin/tclsh --with-features=huge --prefix=/usr/ --enable-cscope --disable-gui --enable-autoservername='yes'
```

Get vim-plug.

Run `:PlugInstall`

