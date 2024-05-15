require 'faker'

Criterion.create(weight: 5.0)
Criterion.create(weight: 4.0)
Criterion.create(weight: 3.0)
Criterion.create(weight: 2.0)
Criterion.create(weight: 1.0)

100.times do 
  Project.create(name: "#{Faker::Space.meteorite} - #{rand(1..99)}")
end

projects = Project.all

projects.each do |pj|
  ev = pj.evaluations.create(title: Faker::Color.color_name.capitalize)

  5.times do
    ev.grades.create(criterion_id: rand(1..5), score: rand(1.0..10.0).round(2))
  end
  
  frm = 0
  crt = 0

  ev.grades.each do |grade| 
    frm += grade.score * grade.criterion.weight 
    crt += grade.criterion.weight
  end

  weighted_score = (frm / crt).round(2)
  ev.update_attribute('weighted_score', weighted_score)

  scr = 0

  pj.evaluations.each do |evaluation|
    scr += evaluation.weighted_score
  end

  total_score = (scr / pj.evaluations.count).round(2)
  pj.update_attribute('total_score', total_score)
end