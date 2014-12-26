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
    @shop_links = []
    
  end
  attr_reader :user_agent, :shop_links

  
  def run
    page = 'http://labola.jp/reserve/search/area-11'
    fetch_shop_page_links(page)
    # main_category_links = prefecture_list()
    # main_category_links.each do |page|
    #   puts page
    #   fetch_shop_page_links(page)
    #   sleep 3
    # end
  end

  def fetch_shop_page_links(main_category)
    @page_source = open(main_category,"User-Agent" => @user_agent)
    doc = Nokogiri::HTML.parse(@page_source, nil)
    find_result = doc.css("table.left_pager > tr:nth-child(1)").text.scan(/[0-9]+/)
    if find_result[0].to_i > 1 then
      doc.css('table#shop_list').each do |elem|
        elem.css('td > div.menus > a.info').each do |link|
          @shop_links.push("http://labola.jp#{link[:href]}")
        end
      end
    end
  end

  private

  def prefecture_list
    main_category_links = []
    for prefecture_cd in 1..47
      main_category_links.push("http://labola.jp/reserve/search/area-#{prefecture_cd}")
    end
    return main_category_links

  end
end
