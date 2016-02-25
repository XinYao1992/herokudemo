require './lib/map.rb'

class WelcomeController < ApplicationController
  def index
    map = CampusMap.new()
    map.load("./lib/buildings.txt", "./lib/paths.txt")
    @txt = map.solve(1059, 1060)
  end

  

end
