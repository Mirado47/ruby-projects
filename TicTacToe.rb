class Game
  @@wincon = [[0, 1 ,2], [3, 4, 5], [6, 7, 8], [0, 3, 6], 
     [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    def initialize
     
     @winner 
     @turn = 0
     @space = "-"
     @board = Array.new(9, @space)
    end
    def drawboard
      @board.each_slice(3) { |x| puts x.join(" | ") }
    end
    def get_move(token)
      if token == "X"
        puts "Its X's turn to pick a space from 1 to 9"
    	move = gets.chomp!
      elsif token == "O"
    	puts "Its O's turn to pick a space from 1 to 9"
    	move = gets.chomp!
      end
        validate_move(move)
        place_move(move)
     end
     def validate_move(move)
     	move = move.to_i
       if move.between?(1,9)
         if @board[move-1] != "-"
         	puts "Space taken, try another space!"
         	get_move(@token)
         end
       else 
         puts "Numbers 1 - 9 only please!"
         get_move(@token)
       end
     end
     def start
       drawboard
       turns
     end
     def place_move(move)
     	move = move.to_i
     	@board[move-1] = @token
     	drawboard
     	check_wincon
     	turns
     end
     def turns
        @turn += 1
        if @turn.even? 
          @token = "O"
        elsif @turn.odd? 
          @token = "X"
        end
        cat_game
        get_move(@token)
        
        
     end
     def check_wincon
     	@@wincon.each do |winary|
     		if winary.all? { |a| @board[a] == @token }
     			winner
     	  end
     	end
     end
     def winner
     	puts "        #{@token} Takes the win!"
     	game_over
     end
     def game_over
     	@turns = 11
     	puts "          GAME OVER! \r +++++++++++++++++++++++++++++++ \r  Do you want another?, hit Y!"
     	another = gets.chomp!
     	if another.downcase == "y"
     		initialize
     		start
     	end
     end
     def cat_game
     	if @turn > 9
     		@token = "Cat"
     		winner
     	end
     end
end
Game.new.start