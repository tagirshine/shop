require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "product attr must be not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "price attr must be positive" do
    product = Product.new(:title=> "My book title",
    :description=> 'yyy',
    :image_url => 'zzz.gif')
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                 product.errors[:price].join('; ')
    product.price = 0
    assert product.invalid?
    assert_equal "must be greather than or equal to 0.01",
                 product.errors[:price].join('; ')
    product.price = 1
    assert product.valid?

  end
end
