FactoryGirl.define do
  factory :foo do
    first_name "John"
    last_name  "Doe"
    admin false
  end

  # This will use the User class (Admin would have been guessed)
  factory :bar, class: User do
    first_name "Admin"
    last_name  "User"
    admin      true
  end
end