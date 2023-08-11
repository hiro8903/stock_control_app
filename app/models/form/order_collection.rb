class Form::OrderCollection < Form::Base
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  FORM_COUNT = 10 #ここで、作成したい登録フォームの数を指定
  attr_accessor :collection  # ここに作成したOrderモデルが格納される

  # 初期化メソッド
  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        if value["paint_id"].present? && value["quantity"].present?
          Order.new(
            paint_id: value["paint_id"],
            user_id: value["user_id"],
            order_on: value["order_on"],
            quantity: value["quantity"],
            desired_on: value["desired_on"],
            note: value["note"],
            registerer_id: value["registerer_id"],
            editor_id: value["editor_id"],
            unit_price: value["unit_price"],
            total_price: value["total_price"]
          )
        end
      end
    else
      self.collection = FORM_COUNT.times.map { Order.new }
    end
  end

  # レコードが存在するか確認するメソッド
  def persisted?
    false
  end

  # コレクションをDBに保存するメソッド
  def save
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        # バリデーションを全てかけたいからsave!ではなくsaveを使用
        is_success = false unless result.save
      end
      # バリデーションエラーがあった時は例外を発生させてロールバックさせる
      raise ActiveRecord::RecordInvalid unless is_success
    end
  rescue
    p 'エラー'
  ensure
    return is_success
  end
end


