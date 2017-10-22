atom_feed do |feed|
  feed.title "Кто Купил #{@product.title}"

  feed.updated @latest_order.try(:updated_at)

  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Заказ #{order.id}"
      entry.summary type: 'xml' do |xml|
        xml.p "Отправка в #{order.city}"

        xml.table do
          xml.tr do
            xml.th 'Товар'
            xml.th 'Кол-во'
            xml.th 'Общ.Цена'
            order.line_items.each do |item|
              xml.tr do
                xml.td item.product.title
                xml.td item.quantity
                xml.td number_to_currency item.count_line_item_price
              end
            end
          end
        end
        xml.tr do
          xml.th 'Сумма', colspan: 2
          xml.th number_to_currency \
          order.line_items.map(&:count_line_item_price).compact.sum
        end
        xml.tr "Способ опл. #{order.pay_type}"
      end
    end
    # entry.author do |author|
    #   author.name order.name
    #   author.email order.email
    # end
  end
end