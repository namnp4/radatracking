module Tagmanager
  class ProductsController < TagBaseController
    before_action :set_resource, only: [:edit, :show, :update, :destroy, :edit_tags, :update_tags]
    before_action :set_resources, only: [:index, :new, :edit]

    def index
    end

    def create
      product = update_with_params Product.new(), params[:product]
      try_save(product) { redirect_to tagmanager_product_path(product) }
    end

    def new
    end

    def edit
    end

    def show
    end

    def update
      product = update_with_params @product, params[:product]
      try_save(@product) { redirect_to tagmanager_product_path(@product) }
    end

    def destroy
      @product.delete
      redirect_to tagmanager_products_path
    end

    def edit_tags
      @tags = Tag.all
      @target_update_path = tags_update_tagmanager_product_path(@product)
      render_edit_tags @product, @target_update_path, @tags
    end

    def update_tags
      @product.tags = Tag.where(:id.in => params[:product][:tags])
      try_save(@product) { redirect_to tagmanager_product_path(@product) }
    end

    private

    def update_with_params(product, product_param)
      product.code = product_param[:code]
      product.parent_id = product_param[:parent] if product_param[:parent].present?
      product.subs = Product.where(:id.in => product_param[:subs])
      product.tag_groups = TagGroup.where(:id.in => product_param[:tag_groups])
      product
    end

    def set_resource
      @product = Product.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound => dnf
      render_404
    end

    def set_resources
      @products = Product.all
      @tag_groups = TagGroup.all
    end
  end
end
