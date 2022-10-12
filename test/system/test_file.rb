require "open-uri"
require "json"

# Generate random grid of letters, same letter can appear numerous times
# every letter of user's word must be contained in randomgrid
# must be an english word (aka must match with API)
# error if not english word or use letters not in the grid
# longer the word, better score. shorter time, better score.

# -----------------------------------------------------------
# Generating random grid (min 3 letters, max 12 letters

# Generate random letter
random_letter = ('a'..'z').to_a.sample

# Random number of times
random_number = rand(3..12).round

# Empty array to push random letters in to
letters_array = []

# Generate random letter random number of times (does do dupe letters!)
random_number.times do
  letters_array << ('a'..'z').to_a.sample
end

generated_word = letters_array.join

# p random_letter
# p random_number
# p letters_array
# p generated_word
random_test_word = "pigs"
random_test_array = random_test_word.split('')
# p random_test_array

# ==========================================================

# Validating the word we choose

# ==========================================================

# The word must contain letters in the grid ONLY
our_test_word = "pgiis"
# Split array into letters (just do empty apostrophes)
our_test_array = our_test_word.split('')
# use .all? on our_test_array to see if all letters are included
all_in_the_grid = our_test_array.all? { |letter|
  random_test_array.include? (letter)
}

# p all_in_the_grid
# ===============================================================

# check we don't over-use the letters in our word
# if we have generated random word of "A E R O"
# we should not be able to type "A E R R O" and pass
check_overuse = our_test_array.all? do |letter|
  our_test_array.count(letter) <= random_test_array.count(letter)
end

# p check_overuse
# ===============================================================

# Our word must also be same length or less

# our word <= generated_word

# ============================================================

# Using JSON word API
search_term = "pig"
url = "https://wagon-dictionary.herokuapp.com/#{search_term}"

user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)

# p user
# p user["word"]

# ============================================================
# calculate time taken to do
start = Time.now.to_f
p start

finish = Time.now.to_f
p finish

time_taken = (finish - start).round
p time_taken

# ===============================================================


