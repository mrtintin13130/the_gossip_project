class CreatePrivateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :private_messages do |t|
      t.belongs_to :sender, class_name: 'User'
      t.belongs_to :receiver, class_name: 'User'
      t.text :content
      t.timestamp :date

      t.timestamps
    end
  end
end
