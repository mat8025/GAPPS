#/* -*- c -*- */
# "$Id: date.g,v 1.1 1999/09/15 16:12:08 mark Exp mark $"

//<<" doing include date.g \n"


proc get_minute()
{
  return get_date(10)
}




proc get_hms() 
{   
  return get_date(12) 
}

//tv = get_hms()

     //<<" doing date $tv \n"

proc get_month()
{
  return get_date(18)
}


proc get_day()
{
  return get_date(1)
}

proc get_year()
{
  return get_date(8)
}

 


proc get_mdy()
{
  return get_date(2)
}

proc get_dmy()
{
  return get_date(14)
}

proc get_second()
{
  return get_date(11)
}



proc get_hour()
{
#GS_HOUR = 9
 return get_date(9)
}


min = get_minute()

//     <<" doing date $min \n"




