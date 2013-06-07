# coding: utf-8
require 'machinist/active_record'

Deputy.blueprint do
  name      { Faker::Name.name }
  party     { Party.make! }
  uid       { sn }
  state     { "RJ" }
  nickname  { Faker::Name.first_name }
end

Party.blueprint do
  name  { "PSDB" }
end

Company.blueprint do
  name  { Faker::Company.name }
  cnpj  { "#{sn}" }
end

Refund.blueprint do
  company   { Company.make! }
  deputy    { Deputy.make! }
  invoice   { sn }
  value     { rand * 10000 }
  category  { Category.make! }
  date      { Date.today }
end

Category.blueprint do
  name  { sn }
end
