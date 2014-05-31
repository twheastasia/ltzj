total = 10000
arr = [[8440, 99], [5328, 99], [2448, 99], [400, 0]]

RESULT = []

def try_next_recursion(arr, total, index, last_result=[])
  for t in (0..([total/arr[index][0]+5,arr[index][1]].min))
    tmp_result = last_result.dup

    if 0 == index
      tmp_result = [t]
      try_next_recursion arr, total-arr[index][0]*t, index+1, tmp_result.dup
    elsif index == arr.length - 1
      tmp_result << t
      tmp_result.unshift(-(total-arr[index][0]*t))
      RESULT << tmp_result.dup
      next
    else
      tmp_result << t
      try_next_recursion arr, total-arr[index][0]*t, index+1, tmp_result.dup
    end
  end

end

try_next_recursion arr, total, 0


def abs(x)
  x > 0 ? x : -x
end

RESULT.sort{|x,y| abs(x[0]) <=> abs(y[0])}.first(10).each{|x| puts x.inspect}
