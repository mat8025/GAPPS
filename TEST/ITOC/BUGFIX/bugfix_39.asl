///
#{
 BUG 39 {

         end char sequence in last row of multi-row print not printed
         for nd > 1

          <<"%(4,\t{\s, ,\s}\n)%3d$A \n"

        }
#}


opendll("math")

int A[]
int B[] = {16, 3, 2, 13, 5,10,11, 8, 9, 6, 7, 12, 4 ,15, 14, 1}

<<" $(Cab(B)) $(typeof(B)) \n"
<<" $B \n"

  B->Redimn(4,4)

<<"\n $(Cab(B)) \n"

  A = B

<<"%(4,\t<\s, ,\s>\n)%2d$B \n"

<<"\n"

stop!