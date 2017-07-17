require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage (city_link)
	base_page_url="http://annuaire-des-mairies.com"
	page=Nokogiri::HTML(open("#{base_page_url}#{city_link}"))
	mail=page.xpath('//table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p/font')
	mail.each do |x|
	puts x.text
end

end

def get_all_urls_of_val_doise_townhalls ()
	base_page_url="http://annuaire-des-mairies.com/val-d-oise.html"
	page=Nokogiri::HTML(open("#{base_page_url}"))
	links=page.xpath("//a[@class='lientxt']")
	links.each do |link|
		city_link=link["href"].sub! /^\./, ""
		get_the_email_of_a_townhal_from_its_webpage(city_link)
	end
end

get_all_urls_of_val_doise_townhalls


