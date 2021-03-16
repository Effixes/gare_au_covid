class ApplicationController < ActionController::Base
  helper_method :current_player

  def current_player
    @current_player ||= begin
      player_id = session[:player_id]

      Player.find_by(id: session[:player_id]) if player_id
    end
  end

  private

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def set_current_player(player)
    @current_player = player

    session[:player_id] = player.id
  end
end
