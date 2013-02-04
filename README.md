Tailr
=====

Quickly tail local and remote files

Installation
=============

```bash
sudo npm install -g tailr
```

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
