require 'capybara_helper'
require 'common_helper'

Dir["#{File.dirname(__FILE__)}/pages/sections/*_section.rb"].each {|r| load r }
Dir["#{File.dirname(__FILE__)}/pages/forms/*_form.rb"].each {|r| load r }
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each {|r| load r }
