require 'pathname'
require 'simplecov'
require 'coveralls'

if ENV['TRAVIS'] == 'true'
  # don't generate local report as it is inaccessible on travis-ci, which is
  # why coveralls is being used.
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
else
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
end

require 'rspec'
require 'windows_error'

# Use find_all_by_name instead of find_by_name as find_all_by_name will return pre-release versions
gem_specification = Gem::Specification.find_all_by_name('metasploit-version').first

Dir[File.join(gem_specification.gem_dir, 'spec', 'support', '**', '*.rb')].each do |f|
  require f
end

# add project lib directory to load path
spec_pathname = Pathname.new(__FILE__).dirname
root_pathname = spec_pathname.join('..').expand_path
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
support_glob = root_pathname.join('spec', 'support', '**', '*.rb')

Dir.glob(support_glob) do |path|
  require path
end
