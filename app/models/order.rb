class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  PAYMENT_TYPES = ['Оплата на Банковскую Карту', 'Оплата при получении']
  REGIONS = []
  AREAS = []
  Ruuaby.data_path = 'db/'
  Ruuaby.load_data
  Ruuaby.countries['Украина'].each_key { |key| REGIONS << key.to_s }
  REGIONS.each { |region| Ruuaby.countries['Украина'][region].each_key { |key| AREAS << region + ' ' + key.to_s } }
  AREAS.compact.sort!

  validates :pay_type, inclusion: { in: PAYMENT_TYPES, message: 'Выберите тип оплаты' }, presence: { message: 'Укажите способ оплаты' }
  validates :city, presence: { message: 'Укажите населенный пункт доставки' }
  validates :post_office_number, presence: { message: 'Укажите номер отделения Новой Почты' }
  # validates :number, presence: { message: 'Укажите Ваш контактный номер телефона' }, format: { with: /(\A\+3([ -])?8([ -])?0[1-9]{2}([ -])?(\d([ -])?){7}\z)|(\A0([ -])?[1-9]{2}([ -])?(\d([ -])?){7}\z)/x, message: 'Введите номер телефона в формате +380971234567' }
  validates :number, presence: { message: 'Укажите Ваш контактный номер телефона' }
  validates :first_name, presence: { message: 'Укажите Ваше Имя' }
  validates :last_name, presence: { message: 'Укажите Вашу Фамилию' }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def order_total_price
    line_items.to_a.sum { |item| item.count_line_item_price.to_f }
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
