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

    TRACKING_SESSION_TIME_IN_MILLIS = 3600000

    def ping
      render json: {
        message: "Rada worked!"
      }
    end

    def generation_clientID
      code = rand_string
      t = time_now_millis
      return client_id = code + t.to_s
    end

    def request_cid
      if params["action"] == "request_cid"
        cid = generation_clientID
        render :json => {
          client_id: cid,
          tracking_session: check_tracking_session
        }
      end
    end

    def rada_track
      data = JSON.parse params[:source]
      # client_id = params[:client_id].blank? ? generation_clientID : params[:client_id]
      client_id =  params[:client_id]
      ip = params[:ip].blank? ? request.remote_ip : params[:ip]
      tracking_session = params[:tracking_session];
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
        rd.category = d['data']['category']
        rd.target = d['data']['target']
        rd.extras = d['data']['extras']
        rd.tracking_session = tracking_session
        rd.save
      end
      render :json => {
        client_id: client_id,
        tracking_session: check_tracking_session
      }
    end

    private
    def check_tracking_session
      tracking_session = params[:tracking_session]
      if tracking_session.present? && tracking_session.is_a?(String) 
        val = tracking_session.split('_')[1].to_i;
        return tracking_session if time_now_millis - val < TRACKING_SESSION_TIME_IN_MILLIS
      end
      new_tracking_session
    end

    def new_tracking_session
      "#{rand_string}_#{time_now_millis}"
    end

    def time_now_millis
      (Time.now.to_f * 1000).to_i
    end

    def rand_string
      (0...8).map { (65 + rand(26)).chr }.join
    end

  end
end
