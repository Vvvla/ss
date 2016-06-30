class GooglePage < SitePrism::Page

  include CapybaraHelper
  include CommonHelper

  element :search_textfield, :xpath, "//form[@action='/search']//input[@role='combobox']"
  element :search_button, '#sblsbb button .sbico'

  def wiki_locator(search_word)
    "//h3//a[contains(@href, 'wikipedia.org') and contains(text(), '#{search_word.capitalize}')]"
  end

  def next_images_block?(search_word)
    element_present?("#{wiki_locator(search_word)}/ancestor::div[@class='g']/following-sibling::div[(@id='imagebox_bigimages')]")
  end

  def next_link_after_wiki(search_word)
    if next_images_block?(search_word)
      "#{wiki_locator(search_word)}/ancestor::div[@class='g']/following-sibling::div[not(@id)]/div[1]//h3//a"
    else
      "#{wiki_locator(search_word)}/ancestor::div[@id='rso']/following::*[1]//h3//a"
    end
  end

  def search_from_main_page(word)
    search_textfield.set word
    search_button.click
  end

  def open_wiki_page_for_search_word(search_word)
    find(:xpath, "#{wiki_locator(search_word)}").click
  end

  def open_next_link_after_wiki(search_word)
    find(:xpath, "#{next_link_after_wiki(search_word)}").click
  end

  def store_next_description(search_word)
    find(:xpath, "#{next_link_after_wiki(search_word)}/../..//span[@class='st']").text[0..15]
  end
end