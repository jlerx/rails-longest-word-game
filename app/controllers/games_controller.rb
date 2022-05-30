require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.shuffle[0..9]
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    dictionary = URI.open(url).read
    word = JSON.parse(dictionary)
    word['found']
  end

  def word_appeared_grid(word, grid)
    word_array = word.chars
    word_array_up = word_array.map!(&:upcase)

    word_array_up.all? { |letter| word_array_up.count(letter) <= grid.count(letter) }

  end

  def score
    @answer = params[:word]
    @grid = params[:grid]
    if !word_appeared_grid(@answer, @grid)

      @result = "Sorry this word did not match the grid letters"
    elsif !english_word
      @result = "It's not an english word"
    elsif word_appeared_grid(@answer, @grid) && english_word
      @result = "Great Job"
    end
  end

end
