///
///


//08/22/21   65%
//08/23/21   68%
//08/25/2021 81.82%
//08/26/2021   84.09%
//08/27/2021   86.36%
//08/29/2021   90.91%

////////////////// Good /////////////////////
<|Good =
array
bit
bops
bugs
command
declare
do
dynv
exp
fops
for
func
if
include
ivar
lhsubsc
lists
logic
math
matrix
mops
pan
paraex
proc
ptrs
record
recurse
scope
sfunc
sops
stat
svar
switch
syntax
tests
types
unary
vmf
vops
while
|>
//===========BAD =======================//
<|Bad =
class
oo
threads
try
|>
//=======================================//


<<"%V$Good\n"

<<"$Good[0] $Good[1]\n"
gsz=Caz(Good)
<<"$gsz\n"

<<"%V$Bad\n"

<<"$Bad[0] $Bad[1]\n"
bsz=Caz(Bad)
<<"$bsz\n"




ppc = (gsz*1.0)/(gsz+bsz)  *100

<<"$(date(2)) %6.2f ${ppc}\%\n"


exit()
