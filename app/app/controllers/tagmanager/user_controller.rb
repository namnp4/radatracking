module Tagmanager
  class UserController < TagBaseController
    def index

    end
    def show
      @list_user = User.all
      authorize! :show,@list_user
      render template: "user/list_user"
    end
    def user_detail
      @user_edit = User.find(:id => params[:id])
      render template: "user/user_detail"
    end
    def update
      user_change = User.find(:id => params[:id])
      if params[:approval_cb] == "on"
        user_change.approval = true
      else
        user_change.approval = false
      end

      if params[:admin_cb] == "on"
        user_change.admin = true
      else
        user_change.admin = false
      end
      user_change.save
      redirect_to root_url + "tagmanager/user/list"
    end
    def destroy
      user_destroy = User.find(:id => params[:user_id])
      user_destroy.destroy
      render :json => {message:"delete user success"}
    end
  end
end
