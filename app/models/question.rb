# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  has_many(:answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id)

  belongs_to(:poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id)

  has_many(:responses,
    through: :answer_choices,
    source: :responses)

  def results_bad
    result = Hash.new(0)
    answer_choices.each do |answer_choice|
      result[answer_choice.choice_text] += answer_choice.responses.count
    end
    result
  end

  def results_better
    result = Hash.new(0)
    choices_with_answers = answer_choices.includes(:responses)
    choices_with_answers.each do |thing|
      result[thing.choice_text] += thing.responses.length
    end

    result
  end

  # SELECT
  #   answer_choices.*, COUNT(responses.id)
  # FROM
  #   answer_choices
  # LEFT OUTER JOIN
  #   responses ON responses.answer_id = answer_choices.id
  # WHERE
  #   answer_choices.question_id = ?
  # GROUP BY
  #   answer_choices.id;

  def results
    result = {}

    answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS num_responses")
      .joins("LEFT OUTER JOIN responses ON responses.answer_id = answer_choices.id")
      .where("answer_choices.question_id = ?", self.id)
      .group("answer_choices.id")
      .each do |answer_choice|
        result[answer_choice.choice_text] = answer_choice.num_responses
      end

    result
  end
end
