class IssuesController < ApplicationController
  before_action :set_issue, only: %i[edit update destroy]
  before_action :set_selected_product
  # helper_method :product_issues_path_switch
  helper_method :new_product_issue_path_switch
  helper_method :edit_product_issue_path_switch

  def index
    @filter = issue_search_filter

    @issues = Issue.all
    if @product.present?
      @issues = @issues.where("product_id = ?", @product.id)
    end

    if @filter[:findword].present?
      @issues = @issues.where("content LIKE ? OR solution LIKE ?", "%#{@filter[:findword]}%", "%#{@filter[:findword]}%")
    end

    @issues = @issues.page(params[:page])
  end

  def show
  end

  def new
    @issue = Issue.new(flash[:issue])
    @issue.product = @product
    if @current_user.present?
      @issue.responder = @current_user
    else
      @issue.responder = User.new
    end
    # @issue.product_id = @product_id
  end

  def edit
    @delete_button = true
    # @issue_comment = IssueComment.new(flush[:issue_comment])
    @issue_comment = IssueComment.new(issue_id: @issue.id, user_id: @current_user.id)
  end

  def create
    issue = Issue.new(issue_params)

    if issue.save
      redirect_to product_issues_path(issue.product_id), success: '保存しました'
    else
      redirect_to :back, flash: { issue: issue, alert: issue.errors.full_messages }
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_to product_issues_path_switch(@product), success: '更新しました'
      # redirect_to edit_issue_path(@issue), success: '更新しました'
    else
      redirect_to :back, flash: { issue: @issue, alert: @issue.errors.full_messages }
    end
  end

  def destroy
    product_id = @issue.product_id
    @issue.destroy
    redirect_to product_issues_path_switch(@product), success: '削除しました' 
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @issue = Issue.find(params[:id])
    @issue.responder ||= User.new
  end

  def set_selected_product
    # params.fetch(:product, {}).permit(:product_id)
    product_id = params[:product_id]
    # product_name = params[:product_name]
    if product_id.present?
    # if product_name.present?
      @product = Product.find(product_id)
      # @product = Product.find_by(name: product_name)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.require(:issue)
          .permit(
            :product_id, 
            :product_feature, 
            :issue_type_id, 
            :content, 
            :solution, 
            :responder_id, 
            :reporter_name, 
            :site_name)
  end

  def issue_search_params
    params.fetch(:issue, {})
          .permit(
            :product_id, 
            :product_feature, 
            :issue_type_id, 
            :content, 
            :solution, 
            :responder_id, 
            :reporter_name, 
            :site_name)
  end

  def issue_search_filter
    params.fetch(:searcher, {}).permit(:product_id, :findword)
  end


  # custom path methods

  # def product_issues_path_switch(product)
  #   if product.present?
  #     product_issues_path(product)
  #   else
  #     issues_path
  #   end
  # end

  def new_product_issue_path_switch(product)
    if product.present?
      new_product_issue_path(product)
    else
      new_issue_path
    end
  end

  def edit_product_issue_path_switch(product, issue)
    if product.present?
      edit_product_issue_path(product, issue)
    else
      edit_issue_path(issue)
    end
  end

end
