require 'rspec/core/rake_task'

namespace 'kata' do

  desc 'Removes the current code coverage data'
  task :clear_coverage do
    code_coverage_directory = "#{__dir__}/coverage"

    FileUtils.remove_dir(code_coverage_directory, true)
  end


  desc 'Run all of the tests'
  task :test_everything => [:clear_coverage]
  RSpec::Core::RakeTask.new(:test_everything) do |t, _args|
    t.rspec_opts = '--pattern "test/specs/**/*_spec.rb" --force-color'
  end

end

task :default => 'kata:test_everything'
