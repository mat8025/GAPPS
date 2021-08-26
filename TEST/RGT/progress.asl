///
///


//08/22/21   65%
//08/23/21   68%
//08/25/2021 81.82%
//08/26/2021   84.09%

////////////////// Good /////////////////////
<|Good =
bops
sops
fops
syntax
include
if
bit
logic
for
do
proc
switch
scope
while
exp
paraex
types
matrix
func
command
dynv
svar
record
ivar
lists
stat
pan
unary
tests
sfunc
array
declare
math
mops
ptrs
vmf
vops
|>
//===========BAD =======================//
<|Bad =
bugs
recurse
lhsubsc
threads
oo
class
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
