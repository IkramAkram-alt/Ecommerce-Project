class ProductsController < ApplicationController
  before_action :get_user,:set_product, only: %i[ show edit update destroy ]

  # GET /products or /product.json
  def index
    @user = get_user
    @products = @user.products
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @user = get_user
    @product = @user.products.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @user = get_user
    @product = @user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to user_products_path(@user), notice: "product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to user_products_path(@user), notice: "product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to user_products_path(@user), notice: "product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = @user.products.find(params[:id])
    end

    def get_user
      @user = User.find(params[:user_id])
    end
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price,:user_id,:brand,images:[])
    end
end
