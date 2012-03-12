class Movie < ActiveRecord::Base

  def self.rates
    ['G','PG','PG-13','R','NC-17']
  end

  def self.filter_by_rating (rates)
    rate = rates.keys.map {|key| key.to_s} if rates.is_a? Hash
    where(:rating => rate)
  end
end
