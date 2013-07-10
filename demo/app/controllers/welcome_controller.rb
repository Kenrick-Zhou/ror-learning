class WelcomeController < ApplicationController
  def say
  end

  def index
    @agent = request.env['HTTP_USER_AGENT']
    @client_ip = request.remote_ip
    if @client_ip == "218.246.76.5" 
      @domain = "172.16.95.65"
    else
      @domain = "media.kaikeba.com"
    end
  end
  
  def hell
  end
end
