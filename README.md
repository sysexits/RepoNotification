# Git Repository Notification (Mac only)

A Simple Notification Manager for git repositories.
You should register this shell script on crontab.
This script does not permit space for directory names.

# Usage

Ex)
```
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
