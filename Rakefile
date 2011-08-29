require 'rake'
require 'rake/testtask'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'tools/rakehelp'
require 'fileutils'
include FileUtils

setup_tests
setup_clean ["pkg", "lib/*.bundle", "lib/profligacy/*.class", "*.gem", ".config", "lib/profligacy/parser.jar"]

setup_rdoc ['README', 'LICENSE', 'COPYING', 'lib/**/*.rb', 'doc/**/*.rdoc']

desc "Does a full compile, test run"
task :default => ["lib/profligacy/parser.jar", :test]

version="1.1"
name="profligacy"

setup_gem(name, version) do |spec|
  spec.summary = "Profligacy The Swing Reducer."
  spec.description = spec.summary
  spec.author="Zed A. Shaw"
  spec.files += Dir.glob("resources/**/*")
  spec.files += Dir.glob("lib/**/*.rl")
  spec.files += Dir.glob("lib/**/*.java")
  spec.files += Dir.glob("lib/**/*.class")
  spec.files += Dir.glob("lib/**/*.jar")
  spec.platform = "jruby"
end

ragel_java("lib/profligacy/LELParser", "lib/profligacy/parser.jar")
javac_jar("lib", "profligacy", "parser.jar")


task :install => ["lib/profligacy/parser.jar", :test, :package] do
  sh %{sudo gem install pkg/#{name}-#{version}*.gem}
end

task :uninstall => [:clean] do
  sh %{sudo gem uninstall #{name}}
end

task :site do
  sh %{pushd doc/site; webgen; popd}
  sh %{rsync -av doc/rdoc doc/site/output/* rubyforge.org:/var/www/gforge-projects/ihate/profligacy}
end

task :project => [:clean, :default, :test, :rdoc, :package, :site]
