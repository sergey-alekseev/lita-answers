require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start { add_filter '/spec/' }

require 'lita-answers'
require 'lita/rspec'
Dir["#{Dir.pwd}/spec/support/**/*.rb"].each { |f| require f }
