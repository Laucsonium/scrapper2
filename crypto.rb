require 'rubygems'
require 'nokogiri'
require 'open-uri'

def names_crypto()
	coin_market_url="https://coinmarketcap.com/all/views/all/"
	page=Nokogiri::HTML(open(coin_market_url))
	crypto_name=page.xpath("//td[2]/a")
	crypto_name.each do |name|
		puts name.text
	end
end 

def value_crypto()
	coin_market_url="https://coinmarketcap.com/all/views/all/"
	page=Nokogiri::HTML(open(coin_market_url))
	crypto_value=page.xpath("//td[5]/a")
	crypto_value.each do |value|
		puts value.text
	end
end 

names_crypto()
value_crypto()
