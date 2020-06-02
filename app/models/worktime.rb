class Worktime < ApplicationRecord
  def self.list(user_id,month,year)
    where(user_id: user_id, month: month, year: year)
  end
end

