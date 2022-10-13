require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    # ======== display random grid =======================
    # Generate random letter
    random_letter = ('a'..'z').to_a.sample
    # Empty array to push random letters in to
    letters_array = []
    # Generate random letter 10 times (does do dupe letters!)
    10.times do
      letters_array << ('a'..'z').to_a.sample
    end
    # generated_word
    @letters = letters_array.join
  end

  # ======== POST to score action ==============
  def score
    # assign the params[user-word] to variable
    @user_word = params["user-word"]
    # Pass @letters into new page via hidden field in the form
    @letters = params[:letters]
    # trigger the API to check it's real word
    url = "https://wagon-dictionary.herokuapp.com/#{@user_word}"
    word_serialized = URI.open(url).read
    @word_data = JSON.parse(word_serialized)

    # convert our word to array
    our_word_array = @user_word.split('')

    # check we don't over-use the letters in our word or use letters not in grid
    check_overuse = our_word_array.all? do |letter|
      # check count of letters of string against one another
      @user_word.count(letter) <= @letters.count(letter)
    end

    # True or false if word valid according to API
    @true_or_false = @word_data["found"]

    # Length of word
    @word_length = @word_data["length"]

    # Check if word is valid according to API and fulfils rules of game
    if check_overuse && @true_or_false == false
      @response = "You stayed within the rules, but the word is not English"
    elsif check_overuse && @true_or_false
      @points_for_letters = @word_length * 4
      @response = "Word was within the rules and is English!"
      @points_string = "#{@points_for_letters} points!"
    elsif check_overuse == false && @true_or_false == false
      @response = "Better luck next time buddy, pathetic attempt"
    else
      @response = "Your word was out of the rules, but the word was real"
    end

  end
end

# 1. How to persist the score in memory?
# 2. How to generate a timestamp on pageload, and one on submission of form?
# 3. Display points if successful, none if not successful
