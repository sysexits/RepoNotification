# Git Repository Notification

A Simple Notification Manager for git repositories.
You should register this shell script on crontab.
This script does not permit space for directory names.

# files
* update.sh - for Mac OSX
* update_telegram_cli.sh - you can use any system which has telegram-cli binary.

# Usage

Ex)
```
├── A's .repos
├── A's .hashes (if .repos is changed, you should remove this file manually)
├── A
│   ├── Repository_1
│   ├── Repository_2
│   ├── Non Repository
│   ├── Repository_3
│   ├── Non Repository
│   ├── ...
```

in .folder file :
```
/path/to/A (absolute path to A)
```
and you must setup '.repos' at folder A; you can select what you want to receive notification:
```
./Repository_1
./Repository_2
```
Enjoy.
