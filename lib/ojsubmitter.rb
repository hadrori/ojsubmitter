require "ojsubmitter/version"
require "ojsubmitter/logger"
require "ojsubmitter/util"
require 'ojsubmitter/judge/aoj'
require 'ojsubmitter/judge/poj'
require 'ojsubmitter/judge/spoj'
require 'ojsubmitter/judge/codeforces'
require 'ojsubmitter/judge/atcoder'

module OJS
  ROOT_DIR = File.expand_path(File.join(__FILE__, '..', '..'))
end
