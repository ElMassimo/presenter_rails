require "simplecov"
require "coveralls"
SimpleCov.start { add_filter '/spec/' }
Coveralls.wear!

require "presenter_rails"
require "rspec/given"
