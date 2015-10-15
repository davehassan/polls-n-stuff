# == Schema Information
#
# Table name: responses
#
#  id           :integer          not null, primary key
#  responder_id :integer
#  answer_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Response < ActiveRecord::Base
  validates :responder_id, :answer_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cant_respond_to_own_poll

  belongs_to(:answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_id,
    primary_key: :id)

  belongs_to(:respondent,
    class_name: "User",
    foreign_key: :responder_id,
    primary_key: :id)

  has_one(:question,
    through: :answer_choice,
    source: :question)

  def sibling_responses
    self.question.responses.where("responses.id != ? OR ? IS NULL", self.id, self.id)
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(responder_id: self.responder_id)
      errors[:responder_id] << "Can't respond more than once asshole!"
    end
  end

  def author_cant_respond_to_own_poll
    if self.question.poll.author_id == self.responder_id
      errors[:responder_id] << "Can't rig your own poll, sukkah!"
    end
  end

end
