class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :post

      t.string :name
      t.text :content
      t.string :website

      t.timestamps
    end
  end
end
