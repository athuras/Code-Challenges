#!/usr/bin/env ruby
# Given an infix expression consisting only of positive integers, and operators, and parenthesis (not function tokens such as "sin")
# return a prefix string in the same form.
# The program should be executable from the command line acting on a file that contains a single line of text (the infix expression)
# Additionally, when executed with the -r flag, it should return a reduced prefix expression
#
# I have chosen to exclude unary operators (such as factorial), and the reduction does not symbollically factor the result
# the algorithm is my implementation of the "shunting yard" algorithm (for converting from infix to post/prefix).
#
# Cheers.

def reducePrefix( expression, rules )
  aux, out = [], []
  while expression.length > 0 do
    if aux.length == 3
      if rules.key?(aux[2]) and !rules.key?(aux[1]) and !rules.key?(aux[0])
        if aux[0].to_i != 0 and aux[1].to_i != 0
          if aux[2] == '/' and eval(aux[1] + "%" + aux[0]) != 0
            3.times do
              out.push( aux.shift )
            end
          else
            out.push( eval( aux[1] + aux[2] + aux[0] ).to_s )
          end
          aux.clear
          next
        end
      end
      out.push( aux.shift )
    end
    aux.push( expression.pop )
  end
  return aux.reverse + out.reverse
end

args = []
ARGV.each do |arg|
  args.push(arg)
end

input = ""
File.open(args[0],'r') do |e|
  input += e.gets
end

input = input.split(' ')

rules = {} # right-associative is true
rules['^'] = [4,true]
rules['*'], rules['/'], rules['%'] = [3, false], [3, true], [3, true]
rules['+'], rules['-'] = [2, false], [2, false]

out, ops = [], []

input.reverse.each do |a|
  if  !rules.key?(a) and !['(',')'].include?(a)
    out.push(a)
  elsif rules.key?(a)
    oA = rules[a][1] # for clarity in the coming comparison
    oP = rules[a][0]
    until !rules.key?(ops[-1]) or (!oA and rules[ops[-1]][0] <= oP or oA and oP < rules[ops[-1]][0])
      out.push( ops.pop )
    end
    ops.push(a)
  elsif a == ')'
    ops.push(a)
  elsif a == '('
    count = 0
    until ops[-1] == ')' or ops[-1].nil? do
      out.push( ops.pop )
    end
    ops.pop # pop that pesky open Parenthesis
  end
end
while ops.length > 0 do
  out.push( ops.pop )
end
input = out.reverse

if args.include?("-r")
  li, lf = 1, 0
  while li != lf do
    li = input.length
    input = reducePrefix(input, rules)
    lf = input.length
  end
end 

input.each do |e|
  print "#{e} "
end
print "\n"
