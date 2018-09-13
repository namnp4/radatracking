# doc du lieu tu db
# generate file js with data tag into db
module Tagmanager
  class GenerateJsController < ActionController::Base
    layout 'tagmanager_v1'
    def render_script
      # puts params[:product_tag]
      @tags = Tag.all
      @app_name = 'page_test'
      render template: 'tagmanager/tracking.js'
    end

    def test_tracking
      render template: 'tagmanager/tracking.html'
    end

    def render_iframe
      render template: 'tagmanager/iframe'
    end

  end
end
