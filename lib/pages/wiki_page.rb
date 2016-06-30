class WikiPage < SitePrism::Page

  include CapybaraHelper
  include CommonHelper

  element :wiki_logo, '.mw-wiki-logo'
end