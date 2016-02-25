//  test rand
openDll("math")
openDll("stat")
/{

Rand
A= Rand(n,max)
returns a vector of n random numbers in range (1 to max)
or a single number if called with no arguments
if max is not specified the numbers will be in the range 0 and RAND_MAX
as defined on Unix math rand() function.
Use randseed() to seed the random function- 
randseed with no arguments uses unix time function to seed random.

/}

N = 6

randseed(7)

V= Rand(6,42)

<<"$V\n"

U= Rand(6,42,0)

<<"$U\n"

randseed()

U= Rand(6,42,0)

<<"$U\n"

U->sort()

<<"$U\n"

W= Rand(1000,100)

W->sort()

<<"%(10,, ,\n)$W\n"


H= Hist(W,1,0,1)

<<"%(10,, ,\n)$H\n"


L = H

L->sort()

<<"%(10,, ,\n)$L \n"
stop!

