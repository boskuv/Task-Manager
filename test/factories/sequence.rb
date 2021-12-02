FactoryBot.define do
  sequence :string, aliases: [:name, :description, :state, :first_name, :last_name, :password] do |n|
    "string#{n}"
  end
  sequence :email do |n|
    "user#{n}@sample.com"
  end
  sequence :avatar do |n|
    "path/to/avatar#{n}"
  end
  sequence :expired_at do |n|
    DateTime.current + n.days
  end
end
