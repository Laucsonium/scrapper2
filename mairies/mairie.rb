require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'google_drive'
require 'json'


def get_the_email_of_a_townhal_from_its_webpage (city_link)

	base_page_url ="http://annuaire-des-mairies.com"

	page=Nokogiri::HTML(open("#{base_page_url}#{city_link}"))

	mail=page.xpath('//table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p/font')

	mail.each do |x|
	return x.text 
	end


end


def get_all_urls ()

	name_mail_list = {}

	base_page_url ="https://www.annuaire-des-mairies.com/paris.html"

	page=Nokogiri::HTML(open("#{base_page_url}"))

	links=page.xpath("//a[@class='lientxt']")

	links.each do |link|

		city_link =link["href"].sub! /^\./, ""

		city_name =link.text

		email = get_the_email_of_a_townhal_from_its_webpage(city_link)

		name_mail_list.store(city_name, email)

	end
  
end



def export_all_contact ()
session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("140e23cdz7w74t8btsOU5D_VKI-5vuk9SEB--ucTIKWM").worksheets[0]
i = 1

    name_mail_list.each do |nom, adresse|

        ws[i, 1]= "#{nom}"

        ws[i, 2]= "#{adresse}"

        i = i + 1

ws.save

    end


end

export_all_contact