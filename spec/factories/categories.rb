# == Schema Information
#
# Table name: categories
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(TRUE)
#  code                :string
#  handling_percentage :integer
#  name                :string
#  shipping_cost       :float
#  vat_rate            :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryBot.define do
  factory :category do
    name { "MyString" }
    code { "MyString" }
  end
end
