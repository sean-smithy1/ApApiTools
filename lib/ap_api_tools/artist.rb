class Artist

  def initialize
    @artists=get_artists
  end

  def get_artists
    artist_return=HTTP.headers(
      :accept => "application/json",
      'X-Spree-Token': "#{ApApiTools::API_KEY}"
    )
    .get("#{ApApiTools::HOST}/taxonomies?q[name_eq]=Artist")
    JSON.parse(artist_return.body, symbolize_names: true)
  end

  def list
    i=0
    # .first as there should only ever be one due to query above
    @artists[:taxonomies].first[:root][:taxons].map{ |a| { seq: i+=1, id: a[:id], name: a[:name ] } } 
  end

end
