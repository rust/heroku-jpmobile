# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
JpmobileTest::Application.initialize!

eval %Q{ 
  class ActiveSupport::Multibyte::Chars
    def <=>(others)
      0
    end
  end
}
