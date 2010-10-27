class ChatsController < ApplicationController
  before_filter :authorize

  def create
    request.match.chats.create( params[:chat].merge(:player_id => current_player.id)  )
    render :text => 'ok', :layout => false
  end

end
