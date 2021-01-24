class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word()
    return DICTIONARY.sample()
  end
  
  def initialize()
    random = Hangman.random_word()
    @secret_word = random 
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word()
    return @guess_word
  end 

  def attempted_chars()
    return @attempted_chars
  end

  def remaining_incorrect_guesses()
    return @remaining_incorrect_guesses
  end
  
  def already_attempted?(char)
    @attempted_chars.each do |ele|
      if ele == char 
        return true  
      end 
    end 
    return false 
  end 

  def get_matching_indices(char)
    indices = []

    @secret_word.each_char.with_index do |ele, i|
      if ele == char
        indices << i
      end 
    end 
    return indices 
  end 

  def fill_indices(char, indices)
    indices.each do |ele|
      @guess_word[ele] = char 
    end 
  end 

  def try_guess(char)
    
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false 
    end 
    
    @attempted_chars << char     
    indices = self.get_matching_indices(char)
    self.fill_indices(char, indices)

    @remaining_incorrect_guesses -= 1 if indices.empty?   

    return true 
  end 

  def ask_user_for_guess()
    puts "Enter a char:"

    try = gets.chomp

    return self.try_guess(try)
  end 

  def win?()
    
    real_word = @guess_word.join("")
    if real_word == @secret_word
      puts "WIN"
      return true 
    else 
      return false 
    end 
  end 

  def lose?()
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true 
    end  
    return false  
  end 

  def game_over?()
    if self.win?() || self.lose?()
      puts @secret_word
      return true 
    end 
    return false
  end 
end 