class Project < ApplicationRecord
  has_many :tasks

  TOTAL_TASKS = 5

end
