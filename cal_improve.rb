# 升级需要素材
total = 37800

# 现有素材, 单个素材经验固定, 排好序递归效果更佳，需要界面提供特定数值编辑，yy有加减箭头什么的，嘿嘿
arr = [
  [9648, 3],
  [9600, 2],
  [8440, 0],
  [6024, 1],
  [5328, 1],
  [4816, 3],
  [4660, 0],
  [2448, 3],
  [400, 3]
]

RESULT = [] #结果数组

# arr 材料数组, total 剩余经验值, index 当前遍历的第几个材料, last_result 依次存放之前遍历的材料数量(最后吧溢出值放第一个)
def try_next_recursion(arr, total, index, last_result=[])
  # 从0遍历到 (剩余经验/当前材料经验+1)或者材料数量的最大值, 谁小取谁
  for t in (0..([total/arr[index][0]+1,arr[index][1]].min))
    tmp_result = last_result.dup # 数组传递都是引用，防止之后的遍历串改之前的数据, 所以dup了一下
    tmp_result << t # 当前材料数量放入数组

    if index == arr.length - 1 #最后一个材料了
      tmp_result.unshift(-(total-arr[index][0]*t)) # 把材料溢出值放在数组第一个
      RESULT << tmp_result # 放入总结果数组
      next
    else # 继续遍历
      try_next_recursion arr, total-arr[index][0]*t, index+1, tmp_result
    end
  end

end

# 从根数组开始递归
try_next_recursion arr, total, 0

# 绝对值
def abs(x)
  x > 0 ? x : -x
end

# 输出初始材料, 校验用
str = 'assets: '
is_first = true
arr.each_with_index do |value, index|
  next if 0 == value[1] #没有就不输出了......
  str += ", " unless is_first
  is_first = false
  str += "%5d * %2d" % [value[0], value[1]] # 对对齐
end
puts str

# 输出总经验值
puts "total: #{total}"

#      选择溢出值小于400的                 从小到大排序                        前十个
RESULT.select{|x| x[0] >= 0 && x[0] < 400}.sort{|x,y| abs(x[0]) <=> abs(y[0])}.first(10).each do |x|
  str = "%3d wasted: " % x[0]
  is_first = true
  x.each_with_index do |value, index|
    next if 0 == value || 0 == index
    str += ' + ' unless is_first
    is_first = false
    str += "%5d * %2d" % [arr[index-1][0], value]
  end
  puts str
end
