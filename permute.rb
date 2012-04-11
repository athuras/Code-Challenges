class Array

  def swap(i,j)
    set  = self.dup
    set[i], set[j] = set[j], set[i]
    return set
  end

  def displaySorted
    i = 0
    self.sort.each do |e|
      print "#{i}\t#{e}\n"
      i += 1
    end
  end

  def display
    i = 0
    self.each do |e|
      print "#{i}\t#{e}\n"
      i += 1
    end
  end

end

#  I've been thinking about interesting ways to approach the problem of elegantly returning the 
#  permutations of a set. If this were in C, it would be efficient or whatever, but you shoudl get the idea.
#  what I like is that this sort of task (serendipidously how I implemented it) can be very readily made parrallel
#  but I'll leave that for another day.
#
#  Another cool feature, as far as I can tell, the recursion only goes n-1 levels deep for an n-element list.
#  More to come: m-dimensional permutations!

def permute(set, x=0, result=[])
  if x == set.length - 2
    return result.push(set).push(set.swap(x, x + 1))
  end
  n = 0
  until n == set.length - x do
    permute(set.swap(n, x), x + 1, result)
    n+=1
  end
  return result
end
