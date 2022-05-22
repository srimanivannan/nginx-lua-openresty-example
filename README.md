## Simple Example project with tech stack of Lua, openresty, nginx
<br>
Openresty by default enables event based no blocking REST apis
<br>

## Prerequisites
  
### Install openresty
  
  - mkdir $HOME/soft/openresty
  - download the binaries from [here](https://github.com/srimanivannan/mac-local-development-setup/tree/main/downloads/for-openresty-nginx-lua)
  - Extract `openresty-xxx` , `openssl-xx` `pcre-xxx` tar balls
  - cd `openresty-xxx` folder
  - Install openresty using below command
 
    ```sh
    ./configure --with-pcre-jit --with-ipv6 --prefix=/Users/<your_user_folder>/soft/openrestyinstalled --with-pcre=/Users/<your_user_folder>/soft/openresty/pcre-8.44 --with-openssl=/Users/<your_user_folder>/soft/openresty/openssl-1.1.1m
    ```

### Configuration in the PATH

For zsh shell: Add below config in `$HOME/.zshrc` file for zsh shell

```bash
    export LUAJIT_LIB=$HOME/soft/openrestyinstalled/luajit/lib
    export LUAJIT_INC=$HOME/soft/openrestyinstalled/luajit/include/luajit-2.1
    export NGINX_HOME=$HOME/soft/openrestyinstalled/nginx/sbin
    export OPEN_RESTY_HOME=$HOME/soft/openrestyinstalled/bin

    export PATH=$NGINX_HOME:$PATH
    export PATH=$OPEN_RESTY_HOME:$PATH
```

For fish shell: Add below config in `$HOME/.config/config.fish` file for fish shell

```bash
    set -x LUAJIT_LIB $HOME/soft/openrestyinstalled/luajit/lib
    set -x LUAJIT_INC $HOME/soft/openrestyinstalled/luajit/include/luajit-2.1
    set -x NGINX_HOME $HOME/soft/openrestyinstalled/nginx/sbin
    set -x OPEN_RESTY_HOME $HOME/soft/openrestyinstalled/bin

    set -x PATH $PATH $NGINX_HOME
    set -x PATH $PATH $OPEN_RESTY_HOME
```

## Setup

```git
git clone https://github.com/srimanivannan/nginx-lua-openresty-example.git
cd nginx-lua-openresty-example
```

Verify or test the syntax of conf file
```bash
nginx -p $PWD/ -t
```
Run
```bash
nginx -p $PWD/
```
Folder Structure of nginx-lua-openresty-example folder given by `tree .` command<br>
Note: `logs/nginx.pid` will have master process id

```markdown
.
├── README.md
├── conf
│   └── nginx.conf
├── logs
│   ├── access.log
│   ├── error.log
│   └── nginx.pid
└── lua
    ├── conf.lua
    ├── hello.lua
    └── play-with-json-data.lua

```
Run the application with default endpoint. look at nginx.conf
```bash
curl 'http://127.0.0.1:8080/'
```

Run the application with Json Request And Get That Json Response Back. look at nginx.conf
```bash
curl -H "Content-Type: application/json" -X POST -d '{"id": 1, "username":"mani","greetMessage":"Good to see you"}' http://127.0.0.1:8080/postJsonRequestAndGetThatJsonResponseBack

```
```bash
curl 'http://127.0.0.1:8080/getHardCodedJsonResponse'
```
Run the application with Json Request with play-with-json-data.lua
```bash
curl -H "Content-Type: application/json" -kviX POST -d '{"token": "1ety6ki37472nmfhe"}' http://127.0.0.1:8080/playJsonGET

```
if you are making code change then, you will have to restart the nginx process to take effect.

For example, Make some code change in `lua/hello.lua` or `conf/nginx.conf` and restart the process
using below commands.

Verify or test the syntax of conf file
```bash
nginx -p $PWD -s reload -t
```
Run
```bash
nginx -p $PWD -s reload
```
To find the nginx master process id you could use below command

```bash
cat logs/nginx.pid | xargs kill -HUP // might restart process
cat logs/nginx.pid | xargs kill -9 // kill all including child process
```

### How to install thrid party modules or packages in openrusty
Either you can use inbuilt opm command or use luarocks

opm is under `openresty/bin` directory where you installed openresty.

```bash
opm get bungle/lua-resty-reqargs
```

### Documents and references

- [Lua_Nginx_API](https://openresty-reference.readthedocs.io/en/latest/Lua_Nginx_API/)
- [require "resty.reqargs"() module](https://ketzacoatl.github.io/posts/2017-03-03-JSON-POST-processing-in-openresty.html)
- [LUA Manual](http://www.lua.org/manual/5.1/manual.html#pdf-package.seeall)
- [nginx LUA Directives](https://openresty-reference.readthedocs.io/en/latest/Directives/#directives)

