class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine initial: :new_task do
    event :move_to_dev do
      transition new_task: :in_development
    end

    event :return_to_dev do
      transition [:':in_qa,', :':in_code_review'] => :in_development
    end

    event :move_to_qa do
      transition in_development: :in_qa
    end

    event :move_to_code_reveiw do
      transition in_qa: :in_code_review
    end

    event :move_to_pre_release do
      transition in_code_review: :ready_for_release
    end

    event :move_to_released do
      transition ready_for_release: :released
    end

    event :move_to_archived do
      transition [:':new_task,', :':released'] => :archived
    end
  end
end
