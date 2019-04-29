
int c_i;
int c_j;

proc colorRows(r,c)
{
int icr=0;
int jcr = c -1;

    c_j = jcr;

 //for (icr = 0; icr < r ; icr++) {
 //    testargs(cellwo,@cellbhue,LILAC_,jcr,icr,jcr);
 //    testargs(cellwo,@cellbhue,LILAC_,icr,jcr,icr);
//  }


S=testargs(1,cellwo,@cellbhue,icr,1,icr,jcr,LILAC_); icr++;

S=testargs(1,cellwo,@cellbhue,icr,1,icr,jcr,LILAC_); icr++;

S=testargs(1,cellwo,@cellbhue,icr,1,icr,jcr,LILAC_); icr++;
<<"$icr \n";

}

