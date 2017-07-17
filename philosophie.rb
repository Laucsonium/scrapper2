require 'rubygems'
require 'nokogiri'
require 'open-uri'


base_page_url="https://fr.wikipedia.org/wiki/Sp%C3%A9cial:Page_au_hasard"
#base_page_url="https://fr.wikipedia.org/wiki/Paris"
count=0
while base_page_url!="https://fr.wikipedia.org/wiki/Philosophie"
	count+=1

	page=Nokogiri::HTML(open(base_page_url))
	page_title=page.xpath("//*[@id='firstHeading']")
	puts page_title.text
	first_link=page.xpath("//*[@id='mw-content-text']/div/p[1]/a[1]")

	if first_link[0]==nil
		first_link=page.xpath("//*[@id='mw-content-text']/div/p[2]/a[1]")

		if first_link[0]==nil
			first_link=page.xpath("//*[@id='mw-content-text']/div/ul[1]/li/a[1]")
		end

		page_url=first_link[0]["href"]
		base_page_url="https://fr.wikipedia.org#{page_url}"

	elsif first_link[0].text=="prononcé"
		first_link=page.xpath("//*[@id='mw-content-text']/div/p[1]/a[2]")
		ase_page_url="https://fr.wikipedia.org#{page_url}"

	else
		page_url=first_link[0]["href"]
		base_page_url="https://fr.wikipedia.org#{page_url}"
	end


end

puts "#{count} étapes ont été nécessaires pour arriver à la page Philosophie !"
