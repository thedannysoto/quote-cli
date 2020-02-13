require 'nokogiri'
require 'open-uri'
require 'pry'

html = open("https://www.brainyquote.com/authors")

doc = Nokogiri::HTML(html)
binding.pry