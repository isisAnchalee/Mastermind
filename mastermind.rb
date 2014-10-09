class Code
  
  attr_accessor :peg_str
  OPTIONS =  %w(R G B Y O P)
  
  def initialize(peg_str)
    @peg_str = peg_str
  end
  
  def self.generate_random
    peg_str = self::OPTIONS.shuffle[0..3]
    Code.new(peg_str)
  end
  
  def check_code(peg, idx)
    self.peg_str.include?(peg) && peg != self.peg_str[idx]
  end
  
  
end

class Game
  class InputError < StandardError; end
  
  def initialize
    @correct_code = Code::generate_random
    @tries = 0
    @corr_color_and_pos = 0
  end
  
  def play
    puts @correct_code.peg_str
    until win? || @tries == 10
      prompt_user
      user_input = get_user_input
      @tries += 1
      correctness = compare_with_answer(user_input)
    end
    if win?
      puts "You win!"
    else
      puts "You're a failure."
    end
  end
  
  private
  def prompt_user
    puts 'Enter 4 Letters:"R"ed, "G"reen, "B"lue, "Y"ellow, "O"range, "P"urple'
  end
  
  def win?
    @corr_color_and_pos == 4
  end
  
  def get_user_input
    begin
      print "Enter letters: "
      input = gets.chomp
      raise InputError.new("Not a valid input") unless validate_input?(input.split(""))
      input
    rescue InputError => error
      puts error
      retry
    end
  end
  
  def compare_with_answer(input)
    @corr_color_and_pos = 0
    corr_color = 0
    input.split("").each_with_index do |peg, idx|
      puts peg
      puts idx
      @corr_color_and_pos += 1 if peg == @correct_code.peg_str[idx]
      corr_color += 1 if @correct_code.check_code(peg, idx)
    end
    puts "You have #{@corr_color_and_pos} in exactly the right place."
    puts "You have #{corr_color} that are the right color but in the wrong place."
  end
  
  
  def validate_input?(input)
    return false if input.length != 4
    input.all? { |idx| Code::OPTIONS.include?(idx) }
  end
end

meow = Code::generate_random
testgame = Game.new
testgame.play
