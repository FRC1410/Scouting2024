class HealthcheckController < ApplicationController
  def online
    render plain: "Online"
  end
end
