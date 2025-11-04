# Logging Module

This project is a logging module that KX will provide open source and out of the box. It is targeted mainly towards new users as more advanced kdb+ stacks will likely have their own standard or equivalent they've implemented.

## Features

- Levels
    - trace
    - debug
    - info
    - warn
    - error
    - fatal
- Multiple Sinks
    - STDOUT/ERR
    - Filehandles
    - qIPC
- Formats
    - syslog
    - json
    - basic
- Format customisation
- Variable Logging


## API Documentation

:point_right: [`API reference`](docs/reference.md)

## Installation Documentation

:point_right: [`Install guide`](docs/install.md)

## Acknowledgements

This project draws inspiration and borrows some code from the following open-source projects:

- [log4q](https://github.com/prodrive11/log4q) by [prodrive11](https://github.com/prodrive11)
- [kdb-common](https://github.com/BuaBook/kdb-common) by [BuaBook](https://github.com/BuaBook)

Many thanks to the authors and contributors of these libraries for their work.