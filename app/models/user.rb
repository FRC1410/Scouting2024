class User < ApplicationRecord
  def name
    [first_name, last_name].join(" ")
  end
end
