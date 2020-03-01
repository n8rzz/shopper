json.extract! recipe, :id, :name, :description, :prep_time, :cook_time, :yield_value, :yield_unit, :ownable_id, :created_at, :updated_at, :recipe_instructions
json.url recipe_url(recipe, format: :json)
