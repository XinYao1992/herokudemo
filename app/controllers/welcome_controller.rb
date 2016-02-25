require './lib/map.rb'

class WelcomeController < ApplicationController
  def index
    @notes = [1059, 1060]
    if params[:start] != nil && params[:end] != nil
      startP = params[:start].to_i
      endP = params[:end].to_i
      map = CampusMap.new()
      map.load("./lib/buildings.txt", "./lib/paths.txt")
      @result = map.solve(startP, endP).html_safe
    end
  end



end
