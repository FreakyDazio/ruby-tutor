$:.unshift(__dir__)

require 'bundler'
Bundler.require
require 'ruby-tutor/sandbox'
require 'ruby-tutor/exercise'

load File.expand_path("../config/exercises.rb", __dir__)

require 'ruby-tutor/application'
