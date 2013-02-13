#!usr/bin/env python
from collections import Counter


def ss(S, chars):
    '''
    Given a sequence of items S, return the shortest subsequence that containsi
    all the items in chars.

    Usage:
    ss('1231', '13'):
    >> '31'
    ss('1234567891', '1179')
    >> '1234567891'
    ss('', '123')
    >> -1
    ss('Hi there!', 'xlb')
    >> -1
    '''
    def isSubset(x, y):
        for k, v in x.iteritems():
            if y[k] < v:
                return False
        return True

    chars, region = Counter(chars), Counter()
    best = None
    l, r = 0, 0

    while r < len(S):
        # Expand the selection to the right until chars <= region
        while not isSubset(chars, region) and r < len(S):
            region[S[r]] += 1
            r += 1
        # Contract the selection from the left until chars > region
        while isSubset(chars, region) and l < r:
            region[S[l]] -= 1
            l += 1
        # Update the current shortest subsequence
        if best is None or r - l < best[1] - best[0]:
            best = (l - 1, r - 1)

    # Necessary if we never find a substring.
    if best is None or best[0] == -1:
        return -1
    return S[best[0]: best[1] + 1]
