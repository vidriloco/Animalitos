class Geografia < ActiveRecord::Base
  has_one :mascota
    
  def self.build_from(params)
    geo = self.new
    
    geo.coordenada = Point.from_lon_lat(params["lon"].to_f, params["lat"].to_f, 4326)
    geo
  end
  
  def update_from(params)
    self.update_attributes(:coordenada => Point.from_lon_lat(params["lon"].to_f, params["lat"].to_f, 4326))
  end

end
