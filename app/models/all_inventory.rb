class AllInventory < ApplicationRecord
  belongs_to :paint
  with_options presence: true do
    validates :paint_id
    validates :inventory_at
  end
  # 塗料棚卸を登録する際、その塗料、年月の組み合わせが一意であること。
  validates :paint_id, uniqueness: {scope: [:inventory_at]}
  validate :no_future_registration_possible
  
  def no_future_registration_possible
    if inventory_at >= Date.current.beginning_of_month
      errors.add('今月以降の棚卸は確定できません。')
    end
  end

end
