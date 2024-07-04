#!/usr/bin/python3

# a xy plot
# @see https://stackoverflow.com/a/21519229

import sys
import matplotlib.pyplot as plt
from pprint import pprint

li = list(zip(range(1, 14), range(14, 27)))
# pprint(li)

x, y = zip(*li)
plt.scatter(*zip(*li))
plt.show()

sys.exit(0)
