

// test createsem  sem_post sem_wait


int the_val = 0

int Data[10]
int Rdata[10]

Data[2] = 7
Data[3] = 47
<<"$Data  \n"

proc writer()
{

   a_tid = GthreadGetId()

  <<"  thread $a_tid $_cproc\n"
  uint kw = 0

  while (1) {

     sem_wait(s_wid)

     kw++

if ((kw % 200) == 0) {
<<"writing $kw\n"
}
//     sleep(0.01)


     the_val++
     Data[1] = the_val
     sem_post(s_rid)
    

   
  }


}

int k_missed = 0

proc reader()
{

   g_tid = GthreadGetId()
  <<"  thread $g_tid $_cproc\n"


  uint kr = 0
  int last_val = 0
  int rd_val


  while (1) {

     sem_wait(s_rid)


     kr++
     //sleep(0.1)
     rd_val = Data[1]
  
     Rdata->shiftL(rd_val)   
    if ((kr % 200) == 0) {

    <<"reading %V$kr $rd_val $Data[1] $Data[2] \n"
    <<"$Data  \n"



    <<"$Rdata  \n"

     }


    Data[6] = kr

    Data[2] = Data[6]  //  XIC ERROR FIXME
    Data[7] = rd_val

   if ((rd_val - last_val) > 1) {
<<"  missed a write \n"
     k_missed++
     }
     last_val = rd_val
     sem_post(s_wid)

  }


}


   tid = GthreadGetId()

<<" main thread ? $tid \n"

     nt = gthreadHowMany()

<<" how many threads? $nt \n"


// create some semaphores for use by the trains


   s_wid=createSem()

   s_rid=createSem()

   sem_wait(s_rid)   // reader has to wait initially



<<"%V$s_rid $s_wid  \n"

    sv = getSemVal(s_wid)

<<"%V$sv\n"
   writer_id = gthreadcreate("writer")

  <<" should be main thread after creating thread %V$writer_id \n"

   mypr = gthreadgetpriority(writer_id)
 
  <<"created thread %V$mypr\n"


   reader_id = gthreadcreate("reader")

  <<" should be main thread after creating thread %V$reader_id \n"

   mypr = gthreadgetpriority(reader_id)
 
  <<"created thread %V$mypr\n"




    while (1) {


       sleep(1)
       if (k_missed > 0)
           break


    }

<<"%V $k_missed\n"

stop!