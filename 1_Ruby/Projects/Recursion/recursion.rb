
def fibs(n)
  return [] if n <= 0
  return [0] if n == 1
  return [0, 1] if n == 2

  array = [0, 1]
  (n - 2).times do
    array.push(array[-1] + array[-2])
  end

  array
end

def fibs_rec(n)
  return [] if n <= 0
  return [0] if n == 1
  return [0, 1] if n == 2

  array = fibs_rec(n - 1)
  array.push(array[-1] + array[-2])
end

def merge_sort(array)
  return array if array.size <= 1

  middle = array.size / 2
  left = merge_sort(array[0..middle])
  right = merge_sort(array[middle..])

  merge(left, right)
end

def merge(left, right)
  result = []
  until left.empty? || right.empty?
    result << (left.first <= right.first ? left.shift : right.shift)
  end

  result += left + right
end

p fibs(8)
p fibs_rec(8)
p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
p merge_sort([105, 79, 100, 110])
