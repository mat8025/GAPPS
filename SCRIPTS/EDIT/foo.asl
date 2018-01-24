///
///
///

int remove_endb = 0;
int remove_startb = 0;
int remove_dbps = 0;
int m;
int kl = 0;

ok = 1;

while (1)
  {

    L = readline (0);

    if (feof (0))
      break;

    kl++;

    spat (L, "DBPR", 0, 1, &m);

    if (m)
      {
	T = ssub (L, "DBPR", "DBPF");
	remove_startb = 1;
	remove_dbps = 1;
	remove_endb = 1;
      }
    else
      {
	T = L;
      }

    if (remove_startb)
      {
	T = ssub (T, "(", "", 1, 0, &m);
	if (m)
	  {
	    remove_startb = 0;
	  }
      }

    if (remove_dbps)
      {
	T = ssub (T, "dbps", "", 1, 0, &m);
	if (m)
	  {
	    remove_dbps = 0;
	  }
      }


    if (remove_endb)
      {

	spat (T, ");", 0, 1, &m);	//  may be on following line(s)
	if (m)
	  {

	    T = ssub (T, ");", ";", 1, 0, &m) ;
	    remove_endb = 0;

	  }

      }


    if (!(spat (T, "dbps") @= ""))
      {

	ok = 0;
	exit ();
      }

    <<"$T\n";			// the final edited line
  }


<<[2]"%V $ok\n";
if (!ok)
  {
    <<" EDIT_ERROR here $kl $T\n";
  }
