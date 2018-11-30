class GamesController < ApplicationController
  def index
    if params[:week]
      @games = Game.where(week: params[:week])
      @num = params[:week]
      if current_user
        picks = User.find(current_user.id).picks.where(week: params[:week])
      end
    else
      game = Game.find_by(home_score: nil)
      @games = Game.where(week: game.week)
      @num = game.week
      if current_user
        picks = User.find(current_user.id).picks.where(week: game.week)
      end
    end
    @teams = []
    if picks
      picks.each do |pick|
        @teams.append(pick.team)
      end
    end
  end
  def picks
    @games = Game.where(week: params[:week])
    user = User.find(current_user.id)
    (0...@games.count).each do |n|
      if params["game_#{n}"]
        if Game.where(week: params[:week], home: params["game_#{n}"]).length > 0
          pick = Game.find_by(week: params[:week], home: params["game_#{n}"]).picks.create(week: params[:week], team: params["game_#{n}"])
          User.find(current_user.id).choices.create(pick: pick)
        elsif Game.where(week: params[:week], away: params["game_#{n}"]).length > 0
          pick = Game.find_by(week: params[:week], away: params["game_#{n}"]).picks.create(week: params[:week], team: params["game_#{n}"])
          User.find(current_user.id).choices.create(pick: pick)
        end
      end
    end
    redirect_to games_path(week: params[:week])
  end
end
