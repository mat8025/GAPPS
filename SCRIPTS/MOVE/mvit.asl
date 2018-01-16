///
///
///

doit = 0
for (a = 1; a < argc(); a++)  {
<<"? mv $_clarg[a] ../vec/$(scat(scut(_clarg[a],-6),\".cpp\"))\n"
if (doit)
  !!"mv $_clarg[a] ../vec/$(scat(scut(_clarg[a],-6),\".cpp\"))"
}

