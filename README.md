# Ojsubmitter

[![Gem Version](https://badge.fury.io/rb/ojsubmitter.svg)](https://badge.fury.io/rb/ojsubmitter) [![Build Status](https://travis-ci.org/hadrori/ojsubmitter.svg?branch=master)](https://travis-ci.org/hadrori/ojsubmitter) [![Coverage Status](https://coveralls.io/repos/github/hadrori/ojsubmitter/badge.svg?branch=master)](https://coveralls.io/github/hadrori/ojsubmitter?branch=master) [![Dependency Status](https://gemnasium.com/hadrori/ojsubmitter.svg)](https://gemnasium.com/hadrori/ojsubmitter)

Submit a source code to the online judge from CLI.

## Requirements

- ruby >= 2.0.0

### Enabled Judges
- [AIZU ONLINE JUDGE](http://judge.u-aizu.ac.jp)
- [PKU JudgeOnline](http://poj.org)
- [Sphere online judge](http://www.spoj.com)
- [Codeforces](http://codeforces.com)

You can also get this list from `ojsubmitter list` command.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ojsubmitter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ojsubmitter

## Configure

Please run below command to create config file to home directory.
You can set the default options of ojsubmitter command.

    $ ojsubmitter init


## Usage

#### Submit

    $ ojsubmitter -j [JUDGE_NAME] -u [USER_NAME] -p [PASSWORD] -l [LANGUAGE] -f [SOURCE_FILE]

To omit these options, you can use config file `.ojsconf.yml` located in your home directory.

#### Help

Please read the help command to get more info.

    $ ojsubmitter help

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hadrori/ojsubmitter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

