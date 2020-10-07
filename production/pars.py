from pyparsing import *
s='version: 0.1.12+13'
number_v = Word(nums + "." + nums + "." + nums)
number_c = Word("+" + nums)
pars_version = Suppress('version:') + number_v + number_c
print (pars_version.parseString(s))
#print(s)