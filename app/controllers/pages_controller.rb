class PagesController < ApplicationController
  def home
    articlesPage = 3
    @currentpage = params.fetch(:page,1).to_i
    
    if(@articles.nil?)
      @articles = getApi()
      @totalPages = @articles.length() / articlesPage
      
    end

    if(@articles.length() > 0)
      @articlesPagination = @articles[@currentpage*articlesPage, articlesPage]
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
