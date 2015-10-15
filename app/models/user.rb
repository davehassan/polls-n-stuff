# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(:authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id)

  has_many(:responses,
    class_name: "Response",
    foreign_key: :responder_id,
    primary_key: :id)

  # <<-SQL
  # SELECT
  #   polls.*, COUNT(questions.id) AS q_per_pol
  # FROM
  #   polls
  # JOIN
  #   questions
  # ON questions.poll_id = polls.id
  # LEFT OUTER JOIN
  #   (SELECT
  #     *
  #   FROM
  #     responses
  #   JOIN
  #     answer_choices ON responses.answer_id = answer_choices.id
  #   WHERE
  #     responses.responder_id = ?) AS my_responses
  # ON
  #   my_responses.question_id = questions.id
  # GROUP BY
  #   polls.id
  # HAVING
  #   q_per_pol = COUNT(my_responses.id)
  # SQL
  #
  #
  # <<-SQL
  # SELECT
  # FROM
  #   polls
  # JOIN
  #   questions AS qs_for_poll
  # ON questions.poll_id = polls.id
  # JOIN
  #   answer_choices AS
  # SQL
  #
  # def completed_polls
  #   Poll
  #     .select("polls.*, COUNT(questions.id) AS q_per_pol")
  #     .joins("JOIN questions ON questions.poll_id = polls.id")
  #     .joins("LEFT OUTER JOIN ")
  # end

end
