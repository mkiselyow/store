module ProductsHelper
  def material_plastic_present
    content_tag(:li, t('sidebar_filter.plastic')) if @product.material_plastic?
  end

  def material_iron_present
    content_tag(:li, t('sidebar_filter.iron')) if @product.material_iron?
  end

  def material_wooden_present
    content_tag(:li, t('sidebar_filter.wood')) if @product.material_wooden?
  end

  def material_fabric_present
    content_tag(:li, t('sidebar_filter.cloth')) if @product.material_fabric?
  end

  def material_another_present
    content_tag(:li, @product.other_desc) if @product.other_desc?
  end

  def material_mixed_present
    content_tag(:li, t('sidebar_filter.mixed')) if @product.mixed?
  end
end
