ActiveRecord::Schema.define do
  self.verbose = false

  create_table :sandwhiches, force: true do |t|
    t.string :bread
    t.string :fillings
  end
end
