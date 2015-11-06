[![Build Status](https://travis-ci.org/masone/codeclimate-clog.svg?branch=master)](https://travis-ci.org/masone/codeclimate-clog)
[![Code Climate](https://codeclimate.com/repos/563c66d46956800cf3000003/badges/2446c6aec8982895361a/gpa.svg)](https://codeclimate.com/repos/563c66d46956800cf3000003/feed)
[![Test Coverage](https://codeclimate.com/repos/563c66d46956800cf3000003/badges/2446c6aec8982895361a/coverage.svg)](https://codeclimate.com/repos/563c66d46956800cf3000003/coverage)

# Code Climate Clog Engine

`codeclimate-clog` is a Code Climate engine that wraps [Clog](https://www.npmjs.com/package/clog-analysis). Clog performs CoffeeScript static analysis. You can run it on your command line using the Code Climate CLI, or on the [codeclimate analysis platform](https://codeclimate.com).

Clog performs the following complexity-related checks:

* Cyclomatic complexity
* Token complexity
* File length
* Function length


### Installation

1. If you haven't already, [install the Code Climate CLI](https://github.com/codeclimate/codeclimate).
2. Run `codeclimate engines:enable clog`. This command both installs the engine and enables it in your `.codeclimate.yml` file.
3. You're ready to analyze! Browse into your project's folder and run `codeclimate analyze`.
