class StatisticsController < ApplicationController
  def index
    @products = Product.all.order(:id)
    create_donut_chart_issue_share()
    create_line_chart_week_summary()
  end

  private 

  def create_donut_chart_issue_share
    issue_share = Issue.left_joins(:product)
                        .select("products.name, count(1) as issue_count")
                        .group("products.name")
                        .order("issue_count desc")
    @issue_share = issue_share.map do |row| 
      newrow = row.attributes
      [newrow['name'],newrow['issue_count']]
    end
    @issue_share_dataset = {
        backgroundColor: [
          "rgba(255, 99, 132, 0.5)",
          "rgba(54, 162, 235, 0.5)",
          "rgba(255, 206, 86, 0.5)",
          "rgba(75, 192, 192, 0.5)",
          "rgba(153, 102, 255, 0.5)",
          "rgba(255, 159, 64, 0.5)",
        ],
        borderAlign: "inner",
      }
  end

  def create_line_chart_week_summary
    # SQLのクロス集計のSELECT文と空データ生成
    empty_data = []
    sql_select = "product_id"
    7.downto(0).each do |i|
      dt = Date.today - i
      sql_select << ",COUNT(CASE WHEN DATE_FORMAT( created_at ,'%Y-%m-%d' ) = '#{dt.to_s}' 
      THEN 1 ELSE NULL END) AS '#{dt.to_s}'"
      # day_count = Issue.where(created_at: dtm ... dtm + 1.day).group(:product_id).count
      empty_data.push([dt.to_s, 0])
    end

    # SQLでクロス集計
    today = Date.today.to_time
    product_issue_result = Issue.where(created_at: today - 7.days ... today + 1.day)
                                .group('product_id')
                                .select(sql_select)
                                .order('product_id')

    # Chart用のフォーマットにする
    @issue_this_week = []

    # productごとに処理
    @products.each do |p|
      # product取り出し
      product_issue_row = product_issue_result.select do |item|
        item.product_id == p.id
      end

      if product_issue_row.present?
        # 配列の1つめを取る
        row = product_issue_row.first.attributes
        row.delete('id')
        row.delete('product_id')
        @issue_this_week.push({
          name: p.name,
          data: row.to_a
        })
      else
        # なかったら空を追加
        @issue_this_week.push({
          name: p.name,
          data: empty_data
        })
      end
    end

    @issuue_this_week_color = [
      'rgba(255, 99, 132, 0.8)',
      'rgba(54, 162, 235, 0.8)',
      'rgba(255, 206, 86, 0.8)',
      'rgba(75, 192, 192, 0.8)',
      'rgba(153, 102, 255, 0.8)',
      'rgba(255, 159, 64, 0.8)'
    ]

    @issue_this_week_dataset = {
      # lineTension: 0,
      # borderWidth: 1
    }
  end

end
