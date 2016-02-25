
proc tock()
{

   dt=FineTimeSince(T)


   dsecs = dt /1000000.0


<<"%I $T $dt $dsecs \n"

}


class clock
{

public:

 int dsecs;
 int x;
  cmf update()
   {

   dt=FineTimeSince(T)

   this->dsecs = dt /1000000.0

<<"%I $T $dt $this->dsecs \n"
   }

  CMF Print()
   {
    <<"%V $rsecs $dsecs $lags $catchup $skipsig\n"
   }


}


clock mickey

 
   T=FineTime()


   dt=FineTimeSince(T)


   dsecs = dt /1000000.0


<<"%I $T $dt $dsecs \n"

     tock()

     mickey->update()


;