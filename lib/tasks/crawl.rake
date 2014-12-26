namespace :crawl do
  desc "Crawl futsal_court_map"
  task :run => :environment do
    crawl = Crawl.new
    crawl.run
  end
end


class Crawl
  require 'open-uri'
  require 'nokogiri'
  require "active_record"
  require "yaml"

  def initialize
    agent = YAML.load_file('config/useragent.yml')
    @user_agent = agent["default"]["name"]
    @page_source = nil
    @subcategory_links = []
    
  end
  attr_reader :user_agent, :subcategory_links

  
  def run
    main_category_links = [
         {area: 'saitama' , url: 'http://labola.jp/reserve/search/area-11'},
         {area: 'tokyo' , url: 'http://labola.jp/reserve/search/area-13'}
                          ]
    for main_category in main_category_links
      fetch_subcategory_links(main_category[:url])
      sleep 3
    end
  end

  def fetch_subcategory_links(main_category)
    @page_source = open(main_category,"User-Agent" => @user_agent)
    doc = Nokogiri::HTML.parse(@page_source, nil)
    puts doc
    # doc.css("#topNavigation").each do |elem|
    #   elem.css("div > ul > li > a").each do |o|
    #     @subcategory_links.push "http://www.ikea.com/#{o[:href]}"
    #   end
    # end
  end

end
