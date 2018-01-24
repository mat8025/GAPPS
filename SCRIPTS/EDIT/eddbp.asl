///
///
///
setdebug(1,"keep");


int remove_endb = 0;
int remove_startb = 0;
int remove_dbps = 0;
int m;
int m2;
int kl = 0;

ok = 1;

while (1)
  {

    L = readline (0);

    if (feof (0))
      break;

    kl++;

    //spat (L, "DBPR ", 0, 1, &m);
    //spat (L, "DBPR(", 0, 1, &m2)

    pma = regex(L,"DBPR\s*\t*(*")
    // use pma=regex(L,"DBPR ")   // DBPR[WS] || DBPR(

    if (pma[0] != -1)
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

	    T = ssub (T, ") ;", ");", 1, 0, &m) ;
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
	break;
      }

    <<"$T\n";			// the final edited line
  }



<<[2]"%V $ok\n";
if (!ok)
  {
    <<[2]" EDIT_ERROR here  $kl $T\n";
  }
