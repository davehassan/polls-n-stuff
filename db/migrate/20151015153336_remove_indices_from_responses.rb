class RemoveIndicesFromResponses < ActiveRecord::Migration
  def change
      remove_index "responses", name: "index_responses_on_responder_id_and_question_id"
  end
end
