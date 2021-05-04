class GamesController < InheritedResources::Base
  # GET /games/1 or /games/1.json
  def show
    @game = Game.find(params[:id])
    game_api=SteamWebApi::Game.new(@game.code)
    @achievments=game_api.achievement_percentages.achievements
    @news=game_api.news.news_items
  end
  
  private

    def game_params
      params.require(:game).permit(:name, :code)
    end

end
