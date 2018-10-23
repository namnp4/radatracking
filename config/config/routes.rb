Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "tagmanager/home#index"
  # root to: "index#show"

  namespace :api do
    resources :tracking, only: %w[] do
      collection do
        # get :get_script,to: 'tracking_api#render_script'
        # get :track, to: 'tracking_api#track'
        post :rada_track, to: 'tracking_api#rada_track'
        post :generate_client_id, to: 'tracking_api#request_cid'
        post :ping_server, to: 'tracking_api#ping'
      end
    end
  end

  namespace :tagmanager do
    get   "/main",to: 'home#index'
    get   "/tracking_test",  to: 'generate_js#test_tracking'
    get   "/iframe",  to: 'generate_js#render_iframe'
    get   "/view_tag/:id", to: "home#view_tag"
    post  "/create", to: 'home#create'
    get   "/list", to: 'home#show'
    get   "/edit_tag/:id" ,to: 'home#update_tag'
    post  "/save_edit_tag", to: 'home#save_edit_tag'
    delete   "/delete_tag", to: 'home#destroy'
    get   ":product_tag/radareporter.js", to: 'generate_js#render_script'

    # get   :details, to: 'home#details'
    resources :products do
      get 'tags/edit', to: 'products#edit_tags', on: :member
      patch 'tags/update', to: 'products#update_tags', on: :member
    end

    resources :tag_groups do
      get 'tags/edit', to: 'tag_groups#edit_tags', on: :member
      patch 'tags/update', to: 'tag_groups#update_tags', on: :member
    end


    get "/user/list",to: 'user#show'
    get "/user/edit/:id",to: 'user#user_detail'
    post "/user/update/:id",to: 'user#update'
    delete "/user/delete_user",to: 'user#destroy'
  end

end
