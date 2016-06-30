Given(/^I navigate to 'Google' start page$/) do
  page.driver.browser.manage.delete_all_cookies
  @svitlatest = SvitlaTest.new
  visit('https://www.google.com')
end

Given(/^I fill search field with following data: '(.*)'$/) do |word|
  @search_word = word
  @svitlatest.google_page.search_from_main_page(@search_word)
end

When(/^I open wikipedia page for search word$/) do
  @svitlatest.google_page.open_wiki_page_for_search_word(@search_word)
end

When(/^I make a screenshot with name '(.*)'$/) do |name|
  make_screenshot(name)
end

When(/^I open link after wikipedia and remember it description$/) do
  @description = @svitlatest.google_page.store_next_description(@search_word)
  @svitlatest.google_page.open_next_link_after_wiki(@search_word)
end

When(/^I should see page with search word and stored description$/) do
  expect(page.has_content?(@search_word)).to be_truthy
  expect(page.has_content?(@description)).to be_truthy
end

Then(/^I should see wikipedia page$/) do
  @svitlatest.wiki_page.wait_until_wiki_logo_visible
  expect(page.driver.current_url).to include 'wikipedia.org'
end

Then(/^I should see that page has content: '(.*)'$/) do |words|
  expect(page.has_content?(words)).to be_truthy
end