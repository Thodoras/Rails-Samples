class Profile < ActiveRecord::Base
  belongs_to(:user)
  validate(:at_least_one_not_nil)
  validate(:one_of_two_genders)
  validate(:male_not_sue)

  def at_least_one_not_nil
  	if first_name.nil? && last_name.nil?
  		errors.add(:last_name, "at least one between first_name or last_name should not be null")
  	end
  end

  def one_of_two_genders
  	if gender != "male" && gender != "female"
  		errors.add(:gender, "gender should be either male or female")
  	end
  end

  def male_not_sue
  	if gender == "male" && first_name == "Sue"
  		errors.add(:gender, "A male cannot be named Sue")
  	end
  end

  def self.get_all_profiles(min_birth, max_birth)
  	Profile.where("birth_year BETWEEN :min_date AND :max_date", min_date: min_birth, max_date: max_birth).order(birth_year: :asc)
  end
end
