class Project < ApplicationRecord
  has_many :tasks

  TOTAL_TASKS = 5

  def workingdays_list
    eval(self.workingdays)
  end

end
