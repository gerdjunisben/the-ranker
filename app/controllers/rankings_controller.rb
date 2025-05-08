class RankingsController < ApplicationController
    before_action :authenticate_user!
    def index
        @user = current_user
        @rankings = Ranking.where(user: @user)
    end

end