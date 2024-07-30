class CreateAnnonces < ActiveRecord::Migration[7.1]
  def change
    create_table :annonces do |t|
      t.string :annonceId
      t.string :title
      t.float :distance
      t.string :fullAddress
      t.string :url
      t.text :description
      t.date :creationDate
      t.string :contractType
      t.string :contractDescription
      t.string :type

      t.timestamps
    end
  end
end
