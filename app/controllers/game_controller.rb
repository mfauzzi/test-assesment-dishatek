class GameController < ApplicationController
    def index
        @board = [['', '', ''], ['', '', ''], ['', '', '']] unless @board
        @current_player = 'X'
        @player_names = { 'X' => '', 'O' => '' } unless @player_names
        @game_over = false unless @game_over
    end

    def update
        unless params[:player_name].present?
          row = params[:row].to_i
          col = params[:col].to_i
          if valid_move?(row, col) && !@game_over
            @board[row][col] = @current_player
            if check_winner || board_full?
              @game_over = true
            else
              @current_player = @current_player == 'X' ? 'O' : 'X'
            end
          end
        else
          set_player_names(params[:player_name])
        end
        render :index
    end
      

    def reset
        @board = [['', '', ''], ['', '', ''], ['', '', '']]
        @current_player = 'X'
        @player_names = { 'X' => '', 'O' => '' }
        @game_over = false
        render :index
    end

    private

    def set_player_names(name)
        @player_names ||= { 'X' => '', 'O' => '' } # inisialisasi jika belum ada
        if @player_names['X'].empty?
            @player_names['X'] = name
        elsif @player_names['O'].empty?
            @player_names['O'] = name
        end
    end
      

    def valid_move?(row, col)
        @board && @board[row] && @board[row][col] && @board[row][col].empty?
    end

    def check_winner
    # Implement logic to check for a winner
    end

    def board_full?
        @board.flatten.none?(&:empty?)
    end
end
