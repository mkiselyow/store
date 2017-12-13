module ProductsHelper
  def material_plastic_present
    content_tag(:li, 'Пластик') if @product.material_plastic?
  end

  def material_iron_present
    content_tag(:li, 'Железо') if @product.material_iron?
  end

  def material_wooden_present
    content_tag(:li, 'Дерево') if @product.material_wooden?
  end

  def material_fabric_present
    content_tag(:li, 'Ткань') if @product.material_fabric?
  end

  def material_another_present
    content_tag(:li, @product.other_desc) if @product.material_another?
  end
end
