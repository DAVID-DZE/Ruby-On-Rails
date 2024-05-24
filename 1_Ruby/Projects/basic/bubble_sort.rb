
def bubble_sort(array)
  loop do
    swapped = false
    (array.length-1).times do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
    end
    break if not swapped
  end
  array
end

p bubble_sort([4,3,78,2,0,2])
