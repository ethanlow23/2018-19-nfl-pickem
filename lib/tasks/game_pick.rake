namespace :game_pick do
  desc "Update game picks"
  task get_score: :environment do
    Game.all.each do |game|
      if game.home_score
        if game.home_score > game.away_score
          winner = game.home
          game.picks.each do |pick|
            unless pick.correct
              if pick.team == winner
                pick.update(correct: true)
              else
                pick.update(correct: false)
              end
            end
          end
        elsif game.away_score > game.home_score
          winner = game.away
          game.picks.each do |pick|
            unless pick.correct
              if pick.team == winner
                pick.update(correct: true)
              else
                pick.update(correct: false)
              end
            end
          end
        end
      end
    end
  end
end
