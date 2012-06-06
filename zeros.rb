# given an integer n, determine the number of trailing zeros in n!.
# a lot easier than I originally said in an interview (something about finding pairs of multiples
# of 5 and flooring the product of said multiple with its predecessor, and adding the floor of log10( i*(i-1) )
# to a running count as we decremented n . . . yeah . . .

module Zeros
  include Math
  def zeros10(n)
    count = 0
    i = 1
    while (n / 5**i).floor > 0 do
      count += (n / 5**i).floor
      i += 1
    end
    return count
  end
end
