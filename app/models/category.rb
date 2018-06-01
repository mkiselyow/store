class Category < ApplicationRecord
  has_ancestry

  has_many :products, dependent: :destroy
  has_many :subcategories, class_name: 'Category',
                           foreign_key: :parent,
                           dependent: :destroy

  has_one :parent, class_name: 'Category',
                   primary_key: :parent_id, foreign_key: :id

  accepts_nested_attributes_for :subcategories, allow_destroy: true

  scope :only_parent, -> { where(ancestry: nil) }
  scope :without_subcategory, -> { where('parent_category_id IS NOT NULL') }

  def title_with_ancestors
    "#{ancestors.map{|anc| anc.name}.join(' === ')} === #{name}"
  end

  def self.get_collection_of_categories_ids
    # Rails.cache.fetch("Category.get_collection_of_categories_ids", :expires_in => 10.days) do
      @categories = where(ancestry: nil)
      @acc = []
      @categories.each do |category|
        category_children_collecting_ids(category)
      end
      @acc.map { |id| [category_ancestors_names(id), id] }
    # end
  end

  def self.category_children_collecting_ids(category)
    category.children&.each do |child|
      @acc << child.id
      category_children_collecting_ids(child)
    end
  end

  def self.category_ancestors_names(category_id)
    category = find(category_id)
    "#{category.ancestor_ids.map { |id| find(id).name }.join(' === ')} === #{category.name}"
  end

  CATEGORIES_SELECT = get_collection_of_categories_ids
end
