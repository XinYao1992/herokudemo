require './lib/map.rb'

class WelcomeController < ApplicationController

  def initialize
    @map = CampusMap.new()
    @map.load_buildings("./lib/buildings.txt")
    @map.load_paths("./lib/paths.txt")
    name_list = @map.get_all_nodes_name
    @notes = {}
    name_list.each do |name|
      @notes[name] = name
    end
  end

  def index
    if params[:start] != nil && params[:end] != nil
      startP = @map.get_node_id(params[:start])
      endP = @map.get_node_id(params[:end])
      @result = @map.solve(startP, endP).html_safe
    end
  end


end
