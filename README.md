Tailr
=====

Quickly tail local and remote files

Installation
=============

```bash
npm install -g tailr
```

to add zsh completions:

```bash
tailr completions >> ~/.zshrc
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
tailr list

# tail a specific log:
tailr tail my_remote_log

```

Changelog
=========

0.1.2 (2013-02-04)
-------------------

* Added highlighting

0.1.1 (2013-02-04)
-------------------

* Added zsh completions

