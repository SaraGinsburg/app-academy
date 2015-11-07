def retirement_savings(your_age)
  child_age = your_age / 2
  child_savings = child_age**2
  years_until_retirement = 65 - child_age
  (child_savings) * (years_until_retirement)
end

p retirement_savings(30)
p retirement_savings(50)
