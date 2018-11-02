module Tagmanager
  class HomeController < ApplicationController
    skip_before_action :verify_authenticity_token
    layout 'tagmanager_v1'
    before_action :authenticate_user!
    def index
      # response.headers.delete "X-Frame-Options"
      if current_user.approval
        render template: "tagmanager/home"
      else
        render template: "index"
      end
    end
    def create
      if params.blank?
        flash[:notice] = "Create tag fail,because data tag send from client empty"
        redirect_to root_url
      end
      t = Tag.new
      if !current_user.blank?
        t.user_id = current_user.id
        t.author = current_user.email
      else
        t.user_id = "anonymous_user"
      end
      t.name = params["tag_name"]
      t.selector["dom"] = params["selector"].downcase
      t.selector["compare"] = params["compare"].downcase
      t.selector["value"] = params["selector-value"]
      t.selector["other_value"] = params["selector-other-value"]
      t.trigger["value"] = params["trigger"].downcase
      if !params["other-trigger"].blank?
        t.trigger["other_value"] = params["other-trigger"]
      else
        t.trigger.delete "other_value"
      end

      if !params["other-handle"].blank?
        t.handle["other_handle"] = params["other-handle"]
      else
        t.handle.delete "other_handle"
      end
      t.handle["value"] = params["handle"].downcase
      if !t.name.blank? && !t.selector["value"].blank?
        t.save
        return redirect_to root_url + "tagmanager/list"
      end
       redirect_to root_url
    end
    def show
      # @tags = Tag.order_by(:user_id => "desc")
      current_id = current_user[:id]
      my_tag = Tag.where(:user_id => current_id).to_a
      other_tag = Tag.not_in(:user_id => current_id).to_a
      @tags = my_tag + other_tag
      render template: 'tagmanager/list_tags'
    end

    def update_tag
      id =  params[:id]
      @tag_detail = Tag.where(:id => id).first
      authorize! :update, @tag_detail
      render template: 'tagmanager/edit_tag_detail'
    end

    def save_edit_tag
      tag_id = params[:tag_id]
      data_tag =Tag.where(:id => tag_id).first
      if !params["other-trigger"].blank?
        data_tag.trigger["other_value"] = params["other-trigger"]
      else
        data_tag.trigger.delete "other_value"
      end
      data_tag.name = params["tag_name"]
      data_tag.selector["dom"] = params["selector"]
      data_tag.selector["compare"] = params["compare"]
      data_tag.selector["value"] = params["selector-value"]
      data_tag.selector["other_value"] = params["selector-other-value"]
      data_tag.trigger["value"] = params["trigger"]
      data_tag.handle["value"] = params["handle"]
      data_tag.save

      redirect_to root_url + "tagmanager/list"
    end

    def destroy
      tag_id = params[:tag_id]
      @tag_destroy = Tag.find(:id => tag_id)
      authorize! :destroy, @tag_destroy
      @tag_destroy.destroy
    end

    def view_tag
      id = params[:id]
      @tag_view = Tag.find(:id => id)
      render template: "tagmanager/view_tag_detail"
    end

  end
end
