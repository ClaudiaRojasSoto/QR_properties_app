FactoryBot.define do
  factory :property do
    name { 'MyString' }
    address { 'MyString' }
    description { 'MyText' }
    qr_code_url { 'MyString' }
  end
end
