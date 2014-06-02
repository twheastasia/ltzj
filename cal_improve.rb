total = 35800
arr = [
  [9648, 1],
  [9600, 0],
  [8440, 1],
  [6024, 0],
  [5328, 7],
  [4816, 0],
  [4660, 0],
  [2448, 17],
  [400, 5]]

RESULT = []

def try_next_recursion(arr, total, index, last_result=[])
  for t in (0..([total/arr[index][0]+1,arr[index][1]].min))
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

puts "total: #{total}"

RESULT.select{|x| x[0] >= 0}.sort{|x,y| abs(x[0]) <=> abs(y[0])}.first(20).each do |x|
  str = "%3d waste: " % x[0]
  is_first = true
  x.each_with_index do |value, index|
    next if 0 == value || 0 == index
    str += ' + ' unless is_first
    is_first = false
    str += "%5d * %2d" % [arr[index-1][0], value]
  end
  puts str
end
