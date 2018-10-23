module Tagmanager
  class TagGroupsController < TagBaseController
    before_action :set_resource, only: [:edit, :show, :update, :destroy, :edit_tags, :update_tags]
    before_action :set_resources, only: [:index, :new, :edit]
    def index
    end

    def create
      tag_group = update_with_params TagGroup.new(), params[:tag_group]
      try_save(tag_group) { redirect_to tagmanager_tag_group_path(tag_group) }
    end

    def new
    end

    def edit
    end

    def show
    end

    def update
      tag_group = update_with_params @tag_group, params[:tag_group]
      try_save(tag_group) { redirect_to tagmanager_tag_group_path(tag_group) }
    end

    def destroy
      @tag_group.delete
      redirect_to tagmanager_tag_groups_path
    end

    def edit_tags
      @tags = Tag.all
      @target_update_path = tags_update_tagmanager_tag_group_path(@tag_group)
      render_edit_tags @tag_group, @target_update_path, @tags
    end

    def update_tags
      @tag_group.tags = Tag.where(:id.in => params[:tag_group][:tags])
      try_save(@tag_group) { redirect_to tagmanager_tag_group_path(@tag_group) }
    end

    private
    def update_with_params(tag_group, tag_group_param)
      tag_group.code = tag_group_param[:code]
      tag_group.parent_id = tag_group_param[:parent] if tag_group_param[:parent].present?
      tag_group.subs = TagGroup.where(:id.in => tag_group_param[:subs])
      tag_group.products =  Product.where(:id.in => tag_group_param[:products])
      tag_group
    end

    def set_resource
      @tag_group = TagGroup.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound => dnf
      render_404
    end

    def set_resources
      @tag_groups = TagGroup.all
      @products = Product.all
    end
  end
end
