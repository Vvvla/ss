$: << File.dirname(__FILE__) + '/../lib'

ENVIRONMENT = (ENV['ENVIRONMENT'] || 'production').to_sym
raise "You need to create a configuration file named '#{ENVIRONMENT}.yml' under lib/config" unless File.exist? "#{File.dirname(__FILE__)}/../../lib/config/#{ENVIRONMENT}.yml"

require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'site_prism'
require 'rspec'
require 'faker'
require 'env_config'
require 'svitlatest'
require 'pages'
require 'common_helper'
require 'support/string'
require 'gmail'
require 'capybara_helper'
require 'active_support/inflector'
require 'net/http'

World(CommonHelper)
World(CapybaraHelper)

Capybara.configure do |config|
  driver = EnvConfig.get :driver

  case driver

    when 'selenium'
      config.default_driver = :selenium
      config.javascript_driver = :selenium
    else
      raise ArgumentError.new "driver: #{driver} is not supported"
  end

  config.run_server = false
  config.default_selector = :css
  config.default_max_wait_time = 5
  config.app_host = EnvConfig.get :url

  #capybara 2.1 config options
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
end

case Capybara.default_driver
  when :selenium
  Capybara.register_driver :selenium do |app|
    http_client = Selenium::WebDriver::Remote::Http::Default.new
    http_client.timeout = 100
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile["browser.cache.disk.enable"] = false
    profile["browser.cache.memory.enable"] = false
    profile["browser.cache.offline.enable"] = false
    profile.add_extension './features/support/extensions/JSErrorCollector.xpi'
    Capybara::Selenium::Driver.new(app, :browser => :firefox, profile: profile, :http_client => http_client)
  end
  else
    raise ArgumentError.new "driver: #{driver} is not supported"
end

SitePrism.configure do |config|
  config.use_implicit_waits = false
end

Before do
  page.driver.browser.manage.delete_all_cookies
  page.driver.browser.manage.window.maximize

  @random_string = Faker::Lorem.characters(4)
end

After do |scenario|


  if scenario.failed?
    Dir::mkdir('screenshots_failed') unless File.directory?('screenshots_failed')
    screenshot = "./screenshots_failed/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
    page.driver.save_screenshot(screenshot)
    embed screenshot, 'image/png'
  end
  page.driver.browser.manage.delete_all_cookies
end