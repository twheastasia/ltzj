total = 10000
exp1 = 8440
exp2 = 5328
exp3 = 2448

def abs(x)
  x > 0 ? x : -x
end

result = []
for i in (0..(total/exp1+1))
  for j in (0..((total-exp1*i)/exp2+1))
    for k in (0..((total-exp1*i-exp2*j)/exp3)+1)
      result << [exp1*i+exp2*j+exp3*k-total, i, j, k]
    end
  end
end

result.sort{|x,y| abs(x[0]) <=> abs(y[0])}.first(10).each{|x| puts x.inspect}
