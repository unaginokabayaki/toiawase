class IssueTypeController < ApplicationController
  def index
    @issue_types = IssueType.where('id > 0').order(:sort)
  end

  def edit_all
    @issue_types = IssueType.where('id > 0').order(:sort)
  end

  def add_new_row
    @issue_type = IssueType.new
    # render partial: 'table_row', locals: { issue_type: @issue_type }
  end

  def update_all
    issue_types = issue_type_params
    failed = false
    issue_types.each do |item|
      
      # 更新,追加,削除を分けるか
      if item[:deleted].to_i == 1
        next if item[:id].blank? 
        
        issue_type = IssueType.find(item[:id])
        unless issue_type.destroy
          failed = true
        end
      else
        issue_type = IssueType.find_or_initialize_by(id: item[:id])
        unless issue_type.update_attributes(item.slice(:id, :name, :sort))
          failed = true
        end
      end

      if failed
        redirect_to setting_issue_type_edit_all_path, flash: { alert: issue_type.errors.full_messages }
        break
      end
    end

    unless failed 
      redirect_to setting_issue_type_edit_all_path, success: "保存しました"
    end
  end

  private

  def issue_type_params
    params.require(:issue_type).map{ |item| item.permit(%i[id name sort deleted]) }
  end
end
