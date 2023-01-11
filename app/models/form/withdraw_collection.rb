class Form::WithdrawCollection < Form::Base
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  WITHDRAW_NUM = 5
  attr_accessor :collection  # ここに作成したWithdrawモデルが格納される

  # 初期化メソッド
  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        Withdraw.new(
          withdrow_at: value["withdrow_at"],
          user_id: value["user_id"],
          department_id: value["department_id"],
          paint_id: value["paint_id"],
          lot_number: value["lot_number"],
          quantity: value["quantity"]
        )
      end
    else
      self.collection = WITHDRAW_NUM.times.map { Withdraw.new }
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
