
A=ofr("foo")
int ui
long li
ulong uli
ulong LV[10]
i=0
while (1) {
fscanv(A,"L10",&LV);
<<"%u $LV\n"
i++
if (i > 10)
break
}
cf(A)


A=ofr("foo")

int j=0
i=0;
while (1) {
fscan(A,'%d',&j);
//fscanv(A,"I",&j);
//<<"%u $li\n"
fprintf(1,'li= %u \n',j)
i++
if (i > 10)
break
}
cf(A)


