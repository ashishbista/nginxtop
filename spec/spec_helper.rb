$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nginxtop'

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do 
    # Redirect stderr and stdout
    $stderr = File.new(File.join(File.dirname(__FILE__), 'dev', 'null'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'dev', 'null'), 'w')
  end
  config.after(:all) do 
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
