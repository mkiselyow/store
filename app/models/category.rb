class Category < ApplicationRecord

  CATEGORIES_SELECT = get_collection_of_categories_ids
  has_ancestry

  has_many :products
  has_many :subcategories, class_name: 'Category',
                           foreign_key: :parent,
                           dependent: :destroy
  # has_many :subsubcategories, class_name: 'Category',
  #                          foreign_key: :parent_id,
  #                          dependent: :destroy

  has_one :parent, class_name: 'Category',
                   primary_key: :parent_id, foreign_key: :id

  accepts_nested_attributes_for :subcategories, allow_destroy: true
  # accepts_nested_attributes_for :subsubcategories, allow_destroy: true

  scope :without_parent, -> { where(parent_category_id: nil).where(parent_subcategory_id: nil) }
  scope :without_subcategory, -> { where('parent_category_id IS NOT NULL') }

  def get_collection_of_categories_ids
    @categories = Category.where(ancestry: nil)
    @acc = []
    @categories.each  do |category|
      category_children_collecting_ids(category)
    end
    @acc
  end

  def category_children_collecting_ids(category)
    if category.children
      category.children.each do |child|
        @acc << child.id
        category_children_collecting_ids(child)
      end
    end
  end
end
