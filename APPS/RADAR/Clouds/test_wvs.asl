
n = 12

char VS[n][6]

for (i = 0 ; i < n ; i++) {

  VS[i][::] = i

}

<<"%(,, \,,\n)$VS"

<<"%(6,, \,,\n)$VS"

Fvs = ofw("vs.csv")

<<"$Fvs\n"

 for (i = 0; i < 3; i  ++) {
wfile(Fvs,"--------\n")
//wfile(Fvs,"%(,, \,,\n)$VS")
wfile(Fvs,"$VS")
wfile(Fvs,"////////////\n")
}

