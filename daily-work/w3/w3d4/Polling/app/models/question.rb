class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: 'AnswerChoice'

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: 'Poll'

  has_many :responses,
    through: :answer_choices,
    source: :responses


  def results
    #### N + 1 algorithm
    # choices = self.answer_choices
    #
    # choices_hash = {}
    #
    # choices.each do |choice|
    #   choices_hash[choice.text] = choice.responses.length
    # end
    #
    # choices_hash

    #### 2
    choices = self.answer_choices.includes(:responses)
    choices_hash = {}

    choices.each do |choice|
      choices_hash[choice.text] = choice.responses.length
    end

    choices_hash
    #
    # choices = self.class.find_by_sql(<<-SQL, self.id)
    #   SELECT
    #     *
    #     -- answer_choices.text,
    #     -- COUNT(answer_choice_id)
    #   FROM
    #     answer_choices
    #   JOIN
    #     responses ON answer_choices.id = responses.answer_choice_id
    #   -- GROUP BY
    #   --   answer_choice_id
    #   WHERE
    #     answer_choices.question_id = ?
    # SQL
    #
    # choices
  end

end
