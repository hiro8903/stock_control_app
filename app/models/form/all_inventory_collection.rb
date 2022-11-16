class Form::AllInventoryCollection < Form::Base
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  ALLINVENTORY_NUM = 1
  attr_accessor :collection  # ここに作成したAllInventoryモデルが格納される

  # 初期化メソッド
  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        AllInventory.new(
          paint_id: value["paint_id"],
          inventory_at: value["inventory_at"],
          quantity: value["quantity"]
        )
      end
    else
      self.collection = ALLINVENTORY_NUM.times.map { AllInventory.new }
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
