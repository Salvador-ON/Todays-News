class PagesController < ApplicationController
  def home
    articlesPage = 3
    @currentpage = params.fetch(:page,1).to_i
    
    if(@articles.nil?)
      @articles = getApi()
      @articlesTop = @articles.take 3
      @articles = @articles.drop 3
      @totalPages = @articles.length() / articlesPage
    end

    if(@articles.length() > 0)
      @articlesPagination = @articles[@currentpage*articlesPage, articlesPage]
    end
    @articlesPagination
  end

  def getApi
    require 'open-uri'
    require 'json'
    url = 'http://newsapi.org/v2/top-headlines?'\
          'country=us&'\
          'apiKey='
    req = open(url+ENV["ApiKey"])
    response_body = JSON.parse(req.read) 
    result =  response_body["articles"]

    articles = Array.new

    result.each do |element|
      article = Hash.new 
      article["source"] = element["source"]["name"]
      article["title"] = element["title"]
      article["url"] = element["url"]
      article["urlToImage"] = (!element["urlToImage"].nil? ? element["urlToImage"] : "https://i.picsum.photos/id/2/800/600.jpg") 
      article["author"] = getAutor()
      articles.push(article)
    end
    articles
  end

  def getAutor
    require 'open-uri'
    require 'json'
    url = 'https://randomuser.me/api/'
    req = open(url)
    response_body = JSON.parse(req.read)
    author = Hash.new 
    author["first"] = response_body["results"][0]["name"]["first"]
    author["last"] = response_body["results"][0]["name"]["last"]
    author["pic"] = response_body["results"][0]["picture"]["thumbnail"]
    author
  end

end
