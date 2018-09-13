module Tagmanager
  class TagBaseController < ApplicationController
    skip_before_action :verify_authenticity_token
    layout 'tagmanager_v1'

    def render_404
      respond_to do |format|
        format.html { render template: 'public/404.html', status: 404 }
        format.all { render nothing: true, status: 404 }
      end
    end

    def try_save(target)
      if target.save
        if block_given?
          yield
        else
          redirect_to root_path
        end
      else
        render json: { error: target.errors.full_messages }, status: 200
      end
    end

    def render_edit_tags(target, update_path, tags)
      render template: 'tagmanager/tags/edit_tags', locals: { target: target, update_path: update_path, tags: tags}
    end
  end
end
