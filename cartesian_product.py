#!/usr/bin/env python
'''
For problem answer:

    >> import cartesian_product
    >> words = "the quick brown fox etc"
    >> cartesian_product.p(words)
    >> ---much gibberish---

'''
from sys import maxint


class SM():
    '''Variable-size ring-counters in series, with overflow'''
    def __init__(self, limits, values=None):
        '''Set up a multi_Ring_counter (with radix-10 overflow)'''
        if values is None:
            values = [0] * len(limits)
        else:
            assert all(values[i] < limits[i] for i in xrange(len(limits)))

        # Extends are for overflow
        limits.append(maxint)
        values.append(0)
        self.bounds = limits
        self.state = values

    def increment(self):
        '''Increment the counter by 1'''
        self.state[0] += 1
        i = 0
        while i < len(self.state) - 1:
            if self.state[i] == self.bounds[i]:
                self.state[i] = 0
                self.state[i + 1] += 1
            else:
                i += 1

    def cycle(self):
        '''yields all possible counter states'''
        n = reduce(lambda x, y: x * y, self.bounds[:-1], 1)
        while n > 0:
            yield self.state[:-1]  # ignore overflow for convenience
            self.increment()
            n -= 1
        return

    def clear(self):
        '''reset all bins to zero'''
        for i in xrange(len(self.state)):
            self.state[i] = 0

    def __str__(self):
        return "SM: state: %s limits: %s" % (self.state, self.limits)

    def __repr__(self):
        return str(self)


def p(words):
    '''
    Given a list of words W = ['ABC', '123', 'DEF', ..., 'XYZ']
    produce every permutation of each letter within each word, one per word.
    For example:
        W = ['abc', '123']
        p(w) = {a1, a2, a3, b1, b2, b3, c1, c2, c3}
    '''
    IndexMachine = SM([len(x) for x in words])
    for indices in IndexMachine.cycle():
        permutation = []
        for index, word in zip(indices, words):
            permutation.append(word[index])
        print ''.join(permutation)
    return
