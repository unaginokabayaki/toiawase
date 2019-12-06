class ProductsController < ApplicationController

  def index
    @products = Product.where('id > 0').order(:sort)
  end

  def edit_all
    @products = Product.where('id > 0').order(:sort)
  end

  def add_new_row
    @product = Product.new
    # render partial: 'table_row', locals: { product: @product }
  end

  def update_all
    products = product_params
    failed = false
    products.each do |item|
      
      # 更新,追加,削除を分けるか
      if item[:deleted].to_i == 1
        next if item[:id].blank? 
        
        product = Product.find(item[:id])
        unless product.destroy
          failed = true
        end
      else
        product = Product.find_or_initialize_by(id: item[:id])
        unless product.update_attributes(item.slice(:id, :name, :sort))
          failed = true
        end
      end

      if failed
        redirect_to setting_products_edit_all_path, flash: { alert: product.errors.full_messages }
        break
      end
    end

    unless failed 
      redirect_to setting_products_edit_all_path, success: "保存しました"
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    
  end

  def product_params
    params.require(:product).map{ |item| item.permit(%i[id name sort deleted]) }
  end
end
