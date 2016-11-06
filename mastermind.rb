class Game
	def initialize
		@playercode 
		@comcode = (1..6).to_a.shuffle.pop(4)
		@playerguess
		@comguess
  end
  
  def start
  	puts "Im thinking of a code of four numbers each between 1 and 6, what are they? separate by commas."
  	@playerguess = gets.chomp!
  	validate_guess
  end
  
  def playguess
  	@corrects = corrects
  	if @corrects.count > 1
  	puts "you have #{corrects} numbers correct! what is your next guess?"
  	@playerguess = gets.chomp!
    end
  	validate_guess
  end
  
  def validate_guess
  	@playerguess = @playerguess.split(',').map! { |x| x.to_i }
  	if @playerguess.all? { |x| x.between?(1,6) }
  		check_guess(@playerguess)
  	else
  		puts "Gimmie a better string dude or dudette..."
  		playguess
  	end
  end
  
  def check_guess(guess)
  	guess = @playerguess
  	code = @comcode
  	@match = []
  	code.each do |x| 
  		if guess.include?(x) 
  		@match << x
  	  end
  	end
  	if @match.count > 0
  		position_check
  		puts @comcode.join
  		
  	else
  		
  	playguess
    end
  end
  
  def position_check
  	i = 0
  	@corrects = []
  	4.times do	
  		if @playerguess[i] == @comcode[i]
  			 @corrects << @comcode[i]
  		end
  		i += 1
  	end
  	playguess
  	puts @comcode.join
  	puts @corrects.count
  	puts @corrects.join
  end
end
Game.new.start