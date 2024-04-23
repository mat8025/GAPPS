///
///
///

   na = argc();

for (a = 1; a < na; a++) {
fn = _clarg[a];
nn = scat("bf",scut(fn,6))
<<"mv $fn $nn\n"
}

<<"///////////////\n"
for (a = 1; a < na; a++)  {
<<"mv $_clarg[a] $(scat(\"bf\",scut(_clarg[a],6)))\n"
!!"mv $_clarg[a] $(scat(\"bf\",scut(_clarg[a],6)))"
}

