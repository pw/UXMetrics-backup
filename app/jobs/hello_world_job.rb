class HelloWorldJob < ApplicationJob
  queue_as :default
def perform
    puts 'Hello World!'
  end
end
