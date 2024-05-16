FactoryBot.define do
  factory(:project) do
    name { Faker::Space.meteorite }
  end
end

FactoryBot.define do
  factory(:criterion) do
    weight { rand(1.0..5.0).round(2) }
  end
end

FactoryBot.define do
  factory(:evaluation) do
    association :project
    title { Faker::Color.color_name.capitalize }
  end
end

FactoryBot.define do
  factory(:grade) do
    association :evaluation
    association :criterion
    score { rand(1.0..10.0).round(2)}
  end
end