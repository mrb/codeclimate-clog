# Code Climate Clog Engine

`codeclimate-clog` is a Code Climate engine that wraps [Clog](https://www.npmjs.com/package/clog-analysis). Clog performs CoffeeScript static analysis. You can run it on your command line using the Code Climate CLI, or on our hosted analysis platform.


### Installation

1. If you haven't already, [install the Code Climate CLI](https://github.com/codeclimate/codeclimate).
2. Run `codeclimate engines:enable clog`. This command both installs the engine and enables it in your `.codeclimate.yml` file.
3. You're ready to analyze! Browse into your project's folder and run `codeclimate analyze`.
