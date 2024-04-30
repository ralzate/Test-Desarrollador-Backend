module Games
    class NumberPuzzleApi < Sinatra::Base
      post '/number_puzzle' do
        size = params[:size].to_i || 3 
        puzzle = NumberPuzzle.new(size: size)
        puzzle.generate_puzzle
  
        Oj.dump(
          puzzle: puzzle.state
        )
      end
  
      post '/number_puzzle/:pid/move' do
        puzzle = NumberPuzzle.where(pid: params[:pid]).first
        return Oj.dump(error: 'Number puzzle not found') unless puzzle
  
        move_result = puzzle.move(params[:direction])
  
        puzzle.save
  
        Oj.dump(
          move_result: move_result,
          puzzle: puzzle.state
        )
      end
  
    end
end