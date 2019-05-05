class HerosController < ApplicationController

  def index
    @heros = Hero.all
    @table_headers = ["Herald Pick", "Herald Win", "Guardian Pick", "Guardian Win", "Crusader Pick", "Crusader Win", 
      "Archon Pick", "Archon Win", "Legend Pick", "Legend Win", "Ancient Pick", "Ancient Win", "Divine Pick", 
      "Divine Win", "Immortal Pick", "Immortal Win"]  
    @attribute_name = ["herald_pick", "herald_win", "guardian_pick", "guardian_win", "crusader_pick", "crusader_win", 
      "archon_pick", "archon_win", "legend_pick", "legend_win", "ancient_pick", "ancient_win", "divine_pick", 
      "divine_win", "immortal_pick", "immortal_win"]
  end

 

end 