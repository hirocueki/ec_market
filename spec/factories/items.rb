FactoryBot.define do
  factory :item do
    name { 'りんご' }
    price { 300 }
    description { 'おいしいりんごです' }
    hidden { false }
    position { 1 }
  end
end
