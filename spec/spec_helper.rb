$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))

begin
  require ".bundle/environment"
rescue LoadError
  require "bundler/setup"
end

require "dm-core"
require "dm-validations"
require "dm-types"
require "dm-timestamps"
require "dm-aggregates"
require "dm-migrations"
