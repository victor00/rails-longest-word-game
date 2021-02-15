require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    vowels = %w[a e i o u y].sample(5)
    @letters = (('a'..'z').to_a - vowels).sample(5)
    @letters << vowels
    @letters.flatten!.shuffle!
  end

  def score
    @word = params[:user_input]
    @letters = params[:letters].downcase.split
    @grid_word = grid_word?(@word, @letters)
    @english_word = english_word?(@word)
    @result = result_score(@word)
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end

  def grid_word?(word, letters)
    # word = "home"
    # letters = ["a", "b", "c", "h", "d", "o", "m", "n", "e"]
    word.chars.all? { |char| letters.include?(char) }
  end

  def result_score(word)
    word.size * 2
  end
end
