module CapybaraHelper

  def wait_for_ajax_requests
    wait_until { page.evaluate_script('jQuery.active === 0') }
  rescue Timeout::Error
    raise 'Ran out of time waiting for Ajax.requests to be empty.'
  end

  def element_visible?(xpath_locator)
    element_present?(xpath_locator) && element_displayed?(xpath_locator)
  end

  def make_screenshot(name)
    Dir::mkdir('screenshots') unless File.directory?('screenshots')
    screenshot = "./screenshots/#{name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
    page.driver.save_screenshot(screenshot)
    embed screenshot, 'image/png'
  end

  private

  def wait_until
    require "timeout"
    Timeout.timeout(20) do
      sleep(0.1) until value = yield
      value
    end
  end

  def element_present?(xpath_locator)
    page.has_xpath?(xpath_locator)
  end

  def element_displayed?(xpath_locator)
    find(:xpath, xpath_locator).visible?
  end

end