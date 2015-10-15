# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  choice_text :text
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class AnswerChoice < ActiveRecord::Base
  validates :choice_text, :question_id, presence: true
  

  has_many(:responses,
  class_name: "Response",
  foreign_key: :answer_id,
  primary_key: :id)

  belongs_to(:question,
  class_name: "Question",
  foreign_key: :question_id,
  primary_key: :id)

end
