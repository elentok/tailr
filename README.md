Tailr
=====

[![Build Status](https://travis-ci.org/elentok/tailr.png?branch=master)](https://travis-ci.org/elentok/tailr)

Quickly tail local and remote files

Installation
=============

```bash
npm install -g tailr
```

to add zsh completions:

```bash
tailr --completions >> ~/.zshrc
```

**NOTE:** If you're using the completions and you get a warning about insecure directories
it's because the owner of the directory ".../node/.../lib/node_modules/tailr/completions"
should be either the root user or the current user.

Configuration
==============

Create a file named '.tailr.coffee' in your home directory:

```coffee
module.exports =
  logs:
    my_remote_log:
      server: 'myserver'
      username: 'myuser'
      port: 1234
      filename: '/path/to/file/on/remote/server.log'
    my_local_log:
      filename: '/path/to/local/file'
```

Usage
======
```
# show the names of the logs specified in ~/.tailr.coffee
tailr --list

# tail a specific log:
tailr my_remote_log

# tail and highlight specified expressions:
tailr my_remote_log expr1
tailr my_remote_log expr1=red
tailr my_remote_log expr1=red,bgWhite
tailr my_remote_log expr1=underline
  # you can use "\_" instead of underline:
tailr my_remote_log expr1=_

```

Changelog
=========

0.2.0 (2013-09-10)
-------------------
* added support for tailing multiple servers at once

0.1.5 (2013-02-26)
-------------------
* remove the 0x0e (ascii 14, shift-out) character before console.log
  (it messes up the terminal).

0.1.4 (2013-02-04)
-------------------

* got rid of the "tail" command (you can now use "tailr {log}")
* "tailr completions" is now "tailr --completions"
* "tailr list" is now "tailr --list"

0.1.3 (2013-02-04)
-------------------

* Highlighting bugfixes
* Improved highlighter: you can now define foreground and background color:

```bash
  tailr tail mylog expr1=red,bgWhite,underline
  tailr tail mylog expr1=red,bgWhite,_
```

* Added partial sudo support (by Avia Aharon)

0.1.2 (2013-02-04)
-------------------

* Added highlighting

0.1.1 (2013-02-04)
-------------------

* Added zsh completions

