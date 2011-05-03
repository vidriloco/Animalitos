# encoding: utf-8
module HelperMethods
  def find_not_link(locator)
    !find(:xpath, XPath::HTML.link(locator))
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
