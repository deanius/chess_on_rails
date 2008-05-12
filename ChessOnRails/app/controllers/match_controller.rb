class MatchController < ApplicationController
	
	before_filter :authorize
	
	# GET /match/1
	def show
		# shows whose move it is 
		@match = Match.find( params[:id] )
		
		@board = @match.board( @match.moves.count )
		@pieces = @board.pieces
		
		#begin candidate new method
		@files = Chess.files
		@ranks = Chess.ranks.reverse

		@viewed_from_side = (@current_player == @match.player1) ? :white : :black
		@your_turn = @match.turn_of?( @current_player )
		
		if @viewed_from_side == :black
			@files.reverse!
			@ranks.reverse!
		end
		#end candidate new method
	end
	
	# GET /match/  GET /matches/
	def index
		# shows primary match
	end
	def index_data
		@matches = @current_player.active_matches
	end

	def status 
		@match = Match.find( params[:id] )
		@your_turn = @match.turn_of?( @current_player) 

		#if request.xhr?
		render :partial => "move_indicator", :locals => {:your_turn => @your_turn} 
	end

	def pieces
		@match = Match.find( params[:id] )
		@files = Chess.files
		@ranks = Chess.ranks.reverse

		if( ! params[:move] )		
			@board = @match.initial_board
			@moves_played = @match.moves.count
		else
			@board = @match.board( params[:move] )
			@moves_played = params[:move]
		end
		@pieces = @board.pieces
	end
	
	# GET /match/new
	def create
		#gets form for creating one with defaults
	end
end
