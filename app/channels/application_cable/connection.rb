module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player
    def connect
      self.current_player = Player.find(request.session[:player_id])
      reject_unauthorized_connection unless self.current_player
    end
  end
end
