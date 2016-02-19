require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end
task default: [:test]

task :build do
  IO.popen('docker build --rm -t codeclimate/codeclimate-clog .') do |io|
    while (line = io.gets)
      puts line
    end
  end
end
