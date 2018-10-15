module Api
  class TrackingApiController < ActionController::Base
    # def render_script
    #   url = params[:url]
    #   if url.blank?
    #     render file: 'public/tracking-default.js'
    #   else
    #     render template: 'spymaster.js.erb'
    #   end
    #     # render template: 'test.js.erb'
    #     # render template: 'spymaster.js.erb'
    # end

    def ping
      render json: {
        message: "Rada worked!"
      }
    end

    def generation_clientID
      code = (0...8).map { (65 + rand(26)).chr }.join
      t = Time.new.to_i
      return client_id = code + t.to_s
    end
    def request_cid
      if params["action"] == "request_cid"
        cid = generation_clientID
        render :json => {
          client_id: cid
        }
      end
    end


    def rada_track
      data = JSON.parse params[:source]
      time_send = params[:time_send]
      # client_id = params[:client_id].blank? ? generation_clientID : params[:client_id]
      client_id =  params[:client_id]
      ip = params[:ip].blank? ? request.remote_ip : params[:ip]
      data.each do |d|
        rd = RadaTrack.new
        rd.client_user = d['data']['user']
        rd.ga_client_id = d['data']['ga_client_id']
        rd.client_version = d['data']['client_version']
        rd.client_os = d['data']['client_os']
        rd.client_browser = d['data']['client_browser']
        rd.app_name = d['data']['app_name']
        rd.app_version = d['data']['app_version']
        rd.referer = d['data']['referer']
        rd.ip = ip
        rd.client_id = client_id
        rd.url = d['data']['url']
        rd.behavior = d["data"]["type_track"]
        rd.value = d['data']['value_track']
        rd.start_time_on_web  = d['data']['time_start']
        rd.extras = d['data']['extras']
        # rd.time_send = time_send.to_i
        rd.save
      end
      render :json => {
        client_id: client_id
      }
    end
  end
end
