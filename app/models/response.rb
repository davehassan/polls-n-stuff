# == Schema Information
#
# Table name: responses
#
#  id           :integer          not null, primary key
#  responder_id :integer
#  question_id  :integer
#  answer_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Response < ActiveRecord::Base

  belongs_to(:answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_id,
    primary_key: :id)

  belongs_to(:respondent,
  class_name: "User",
  foreign_key: :responder_id,
  primary_key: :id)

end
