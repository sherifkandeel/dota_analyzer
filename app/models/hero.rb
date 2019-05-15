class Hero < ApplicationRecord
  validates :id, :localized_name, presence: true, uniqueness: true
  Hero.attribute_names - ['id', 'localized_name', 'updated_at','created_at'].each do |attribute_name|
    validates  attribute_name.to_sym,  presence: true, numericality: { only_integer: true }
  end
  
  def self.table_data
    heros = Hero.all
    data = Hash.new
    body = Hash.new
    headers = Hero.column_names - ['id', 'localized_name', 'pro_pick','pro_ban','pro_win','updated_at','created_at'] 
    headers = headers.map do |header| 
      [ header.titlecase, header, header.titlecase.split[0][0] + " " +  header.titlecase.split[1][0] ] 
    end
    heros.each do |hero| 
      body[hero.id] = (headers.map { |header| [header.second.to_sym , hero[header.second] ]} << [:name,hero.localized_name]).to_h
    end
    data[:headers_data] = headers
    data[:body_data] = body
    data[:totals] =  headers.map do |header| 
      [header.second.to_sym, heros.sum(&header.second.to_sym)] if header.second.include? "pick" 
    end.compact.to_h
    data
  end
end