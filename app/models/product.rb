class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  attr_accessible :description, :image_url, :price, :title

  private

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors[:base] << "Tovar position have!"
        return false
      end
    end


  validates :title , :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with:    %r{\.(gif|jpg|png)$}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }
 validates :price, :numericality=> {:greater_than_or_equal_to=> 0.01}
end
