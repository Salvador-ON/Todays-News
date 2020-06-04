class PagesController < ApplicationController
  def home
    articlesPage = 3
    pages = params.fetch(:page,0).to_i
    
    if(@articles.nil?)
      @articles = getApi()
      
    end

    if(@articles.length() > 0)
      @articlesPagination = @articles[pages*articlesPage, articlesPage]

      puts @articlesPagination
    end
    @articlesPagination
  end

  def news
  end

  def getApi
    require 'open-uri'
    require 'json'
    url = 'http://newsapi.org/v2/top-headlines?'\
          'country=us&'\
          'apiKey=a0ba835db71d40819bda3a75cd1f9c00'
    req = open(url)
    response_body = JSON.parse(req.read) 
    result =  response_body["articles"]

    articles = Array.new

    result.each do |element|
      article = Hash.new 
      article["source"] = element["source"]["name"]
      article["title"] = element["title"]
      article["url"] = element["url"]
      article["urlToImage"] = element["urlToImage"]

      articles.push(article)
    end
    articles
  end

end
