class GamesController < InheritedResources::Base

  private

    def game_params
      params.require(:game).permit(:name, :code)
    end

end
