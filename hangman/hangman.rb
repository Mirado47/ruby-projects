

class Hangman
	@@dictionary = File.readlines('./5desk.txt') { |f| f.read }
    
  def initialize
		@word = choose_word.upcase
		@guess = Array.new(@word.length,"_")
		@health = Array.new(6,"0")
       
  end
  
  def choose_word
    bigenough = []
    @@dictionary.map! do |x|
      x.chomp!    
    end
    @@dictionary.each do |x|
      if x.length >= 6
        x = x.downcase
        bigenough << x
      end
    end
    bigenough[rand(52658)]
  end
  
  def load_list
    loaded = []
    f_hash = {}
    game_list = Dir["./#{@user}/*"]
    game_list.map! do |x|
      x.slice((@user.length+3)..x.length) 
    end
    game_list.sort!
    game_list.each_with_index do |file,i|
      loaded = File.read("./#{@user}/#{file}").split("| ")
      f_hash[i+1] = file 
      puts "#{i+1} - #{loaded[0]}, #{loaded[1]}\n\n"
    end
    choose_load(f_hash)
  end
  
  def choose_load(f_hash)
    puts "Which game to load? give me the index."
    to_load = gets.chomp!.to_i
    f_stamp = f_hash[to_load]
    if File.file?("./#{@user}/#{f_stamp}")
      game_info = File.read("./#{@user}/#{f_stamp}").split("| ")
    end
    @health = game_info[1].scan /\w/
    @guess = game_info[0].scan /\w/
    @word = game_info[2]
  end
  
  def start
    puts 'Hey! whats your name?'
    @user = gets.chomp!
    puts "(L)oad a game, or play a (N)ew one?"
    loader = gets.chomp!.downcase
    if loader == "l"
      load_list
    end
    @@game_index = Time.now.to_i
  	puts "Im thinking of a word with #{@word.length} letters. \n    guess a letter in the word."
  	showboard
  end
  
  def showboard
  	puts "\n\n"
  	puts @guess.join(" ")
  	puts "\n\n\n\n"
  	puts "[#{@health.join(" ")}]"
  	get_letter
  end
  
  def get_letter
  	puts "Give me another letter boss"
  	letter = gets.chomp!.upcase
  	check_letter(letter)
    
  end
  
  def save_game
    directory = @user
    Dir.mkdir(directory) unless File.exists?(directory)
    save_game = File.new("./#{@user}/#{@@game_index}", 'w')
    File.open(save_game, 'w') {}
    File.open(save_game, 'w') { |file| file.write("#{@guess.join(" ")}| #{@health.join}| #{@word}") }
  end
  
  def check_letter(letter)
  	has = false
    word = @word
    word.upcase
  	word = @word.scan /\w/
  	word.each_with_index do |x,i| 
      if word[i] == letter
  		@guess[i] = x 
  		has = true
  	  end
    end
    save_game
  	if has
  		win_con
  	elsif !has
  		bad_guess
  	else
  	    showboard
  	end
  end
  	
  def bad_guess
  	puts 'you suck. I steal your lifes'
  	@health.pop
  	@health.unshift("X")
    save_game
  	lose_con
  end
	
	def lose_con
		if @health[5] == "X"
			puts "fuckin chump, the word was #{@word}"
			puts @health.join(' ')
		else
			showboard
	  end
	end
	
	def win_con
		if @guess.join == @word
			win_screen
		else
			showboard
		end
	end
	
  def win_screen
  	puts "thats the way the news goes \n            YOURE A WINNER  \n!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end
  
end
