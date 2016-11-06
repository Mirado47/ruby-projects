class Game
	
	def initialize
    @pcode 
		@ccode = (1..6).to_a.shuffle.pop(4)
		@pguess
		@cguess
  end
  
  def start
  	puts "I'm thinkin of 4 numbers each between 1 and 6 without duplicates. \n     What are they? \n Separate by commas please."
  	puts @ccode
  	get_valid_guess
  end
  
  def get_valid_guess
  	@pguess = gets.chomp!
  	@pguess = @pguess.split(',').map! { |x| x.to_i }
  	if @pguess.all? { |x| x.between?(1,6) }
  		check_match(@pguess)
  	else
  		puts "Gimmie a better string dude or dudette..."
  		get_valid_guess
  	end
  end
  
  def check_match(pguess)
  	@match = []
  	puts "valid"
   
  	@ccode.each do |x| 
  		if @pguess.include?(x) 
  		@match << x 
  	  end
    end
    check_correct(@pguess,@match)
  end
  
  def check_correct(pguess,pmatch)
  	i = 0
  	@match = pmatch
  	@correct = Array.new(@ccode.count,"")
  	4.times do
  		if @pguess[i] == @ccode[i]
  			@correct[i] = @ccode[i]
  		end
  		i += 1
  	end
  	wincon(@correct)
  end	
  
  def wincon(correct)
  	if correct == @ccode
  	  endgame
    else
    	feedback
  	end	
  end
  
  def endgame
  	puts "            !!!!!!!!!!!!!!!!!! \nYou have guessed my secret code. \n       Im melting or whatever..."
  end
  
  def feedback
  	count = []
    if @match.count > 0
    puts "There are #{@match.count} numbers you guessed in my code. \nKeep guessing I guess. \nNot that I want you to win or anything."
    end
    if @correct.all? { |a| a.is_a? String }
  	puts "\nNo numbers are in the right place. \n \nI bet you're real good at other things though. 
  	\nLike you always use your turn signal or something."
    else
  	  @correct.each do |x|
  		  if x.is_a? Integer
  		  count << x	
  	    end
      end 
      puts "\nThere are #{count.count} numbers in the right place...."
  	    sleep 3
  	    puts "\nIm so happy for you..."
    end
   skipstart
  end
  def skipstart
   	puts "\nGive me your next guess if you feel like wasting your time. \nMy code is unbreakable."
   	get_valid_guess
   end
end
Game.new.start
 