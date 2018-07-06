class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot_idx = rand(array.length)
    pivot = array[pivot_idx]
    left = []
    right = []
    array.each_with_index do |el, idx|
      next if idx == pivot_idx
      el <= pivot ? left << el : right << el
    end
    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - (pivot_idx + 1), &prc)
    array
  end


  def self.partition(array, start, length, &prc)
    return if length < 2
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    pivot = array[start]
    barrier_idx = start + 1
    idx = barrier_idx
    while idx < (start + length)
      curr = array[idx]
      if prc.call(curr, pivot) < 1
        array[idx], array[barrier_idx] = array[barrier_idx], array[idx]
        barrier_idx += 1
      end
      idx += 1
    end
    array[start], array[barrier_idx - 1] = array[barrier_idx - 1], array[start]
    return barrier_idx - 1
  end
end
