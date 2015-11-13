class Response < ActiveRecord::Base
  validates :answer_choice_id, :user_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_created_question

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: 'AnswerChoice'

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  has_one :question_author,
    through: :poll,
    source: :author

  def sibling_responses
    self.question.responses.where('responses.id != ? AND ? IS NOT NULL', self.id, self.id)
  end

  private
  def respondent_has_not_already_answered_question
    # self.sibling_responses.where('respondent_id = ?', self.id)
    if !self.sibling_responses.exists?(:user_id => self.id)
      errors[:already_answered] << "This user has already answered the question!"
    end
  end

  def respondent_created_question
    if question.poll.author.id == self.user_id
      errors[:created_question] << "This user created the question!"
    end
  end

end
