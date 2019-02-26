class AssemblyItem < ApplicationRecord
  belongs_to :assembly
  belongs_to :item
end
