class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :responder_id
      t.integer :question_id
      t.integer :answer_id

      t.timestamps
    end

    add_index :responses, [:responder_id, :question_id], unique: true
    add_index :responses, :answer_id
    add_index :responses, :responder_id
    add_index :responses, :question_id
  end
end
