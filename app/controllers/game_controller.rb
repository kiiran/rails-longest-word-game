require 'open-uri'
require 'json'

class GameController < ApplicationController
  def game
    @grid = Array.new(9) { ('A'..'Z').to_a[rand(26)] }
    @grid = @grid.join(" ")
  end

  def score
    grid_used = params[:grid]
    @answer = params[:answer]
    guess = @answer.chars
    @valid = guess.all? { |letter| guess.count(letter) <= grid_used.count(letter) }
    @start_time = params[:start]
    api_key = "cf537075-2986-4d0d-b7f9-0063b53c6f98"
    response = open("https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=#{api_key}&input=#{@answer}")
    json = JSON.parse(response.read.to_s)
    if json['outputs'] && json['outputs'][0] && json['outputs'][0]['output'] && json['outputs'][0]['output'] != @answer
      @translation = json['outputs'][0]['output']
    end

    # rescue
    #   if File.read('/usr/share/dict/words').upcase.split("\n").include? word.upcase
    #     return word
    #   else
    #     return nil
    #   end
    # end
  end
end

