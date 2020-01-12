# frozen_string_literal: true

# id:           integer
# assembly_id:  integer
# item_id:      integer
# created_at:   datetime
# updated_at:   datetime
# qty:          integer
class AssemblyItem < ApplicationRecord
  belongs_to :assembly
  belongs_to :item
end
