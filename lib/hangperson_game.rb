class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  attr_accessor :word, :guesses, :wrong_guesses
  LOSE = 7

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError if letter.nil? or letter.empty? or letter !~ /[A-Za-z]/
    letter.downcase!
    return false if @wrong_guesses.include?(letter) or @guesses.include?(letter)
    
    if word.include? letter
      @guesses += letter
    else 
      @wrong_guesses += letter
    end
    return true
  end
  
  def word_with_guesses
    @word.gsub(/./) do |letter| 
      @guesses.include?(letter) ? letter : '-'
    end
  end
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= LOSE
    return :win if word_with_guesses == @word
    return :play
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
