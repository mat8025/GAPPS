///////////////////////////////////<**|**>///////////////////////////////////
//                                 event_l.cpp 
//    event handler    
//     
//    @release   CARBON  
//    @vers 1.18 Ar Argon                                                
//    @date Sat Jan  5 21:59:22 2019    
//    @cdate Fri Jan  1 08:00:00 2010  
//    @Copyright   RootMeanSquare - 1990,2019 --> 
//    @author: Mark Terry                                  
//  
// /. .\ 
// \ ' / 
//   - 
///////////////////////////////////<v_&_v>/////////////////////////////////// 

 ///////////////////////////////////<**|**>/////////////////////////////////// 
 //                                 event_l.cpp 
 //       
 //     
 //       CARBON  2.3 He.Li Wed Dec 19 13:25:05 2018    
 //       CopyRight   - RootMeanSquare - 1990,2018 --> 
 //       Author: Mark Terry                                           
 //  
 // /. .\ 
 // \ ' / 
 //   - 
 ///////////////////////////////////<v_&_v>/////////////////////////////////// 
 
  #include "event_l.h"
  #include "wcomsf.h"
  
  //////////////////////   GEVENT /////////////////////////////////////
  //
  //
  /// basically reads out last event from global
  /// built when  E->waitforMsg() or E->readMsg()  issued
  ///
  /// TBF - event class - each instance has record of event
  /// now have GEVENT class partially implemented
  
  
  int
  Vmf::setevent (Siv * sivp, Svarg * s)
  {
    s->result->Store (-1);
  
    if (sivp->setEvent (&Gev))
      {
        return s->result->Store (1);
      }
    else
      return 0;
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventid (Siv * sivp, Svarg * s)
  {
  
    if (sivp->getType () == GEVENT)
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	s->result->Store (ep->mp.evid);
      }
    else
      return s->result->Store (Gev.mp.evid);
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventbutton (Siv * sivp, Svarg * s)
  {
    if (sivp->checkType (GEVENT))
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	{
  	  s->result->Store (ep->button);
  	}
        else
  	{
  	  dberror ("bad event var \n");
  	}
      }
    else
      return s->result->Store (Gev.button);
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventetype (Siv * sivp, Svarg * s)
  {
       if (s->result != NULL)
    s->result->freeSivMem ();
    if (sivp->getType () == GEVENT)
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL) {
          DBT("evid %d etype %d %s\n",ep->mp.evid, ep->etype, ev_name(ep->etype));
  	s->result->Store (ep->etype);
        }
      }
    else
      return s->result->Store (Gev.etype);
  }
  //[EF]===================================================//
  int
  Vmf::geteventtype (Siv * sivp, Svarg * s)
  {
    //ev_type = Ev->getEventType(evid,etype,ev_woid,ev_woaw,ev_button,ev_keyc);
    if (s->result != NULL)
    s->result->freeSivMem ();
    
    if (sivp->getType () == GEVENT)
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL) {
  	
  	DBP("evid %d etype %d woid %d %s proc <%s>\n",ep->mp.evid, ep->etype, ep->woid,ev_name(ep->etype), ep->woproc);
  
  	  if (s->AnotherArg()) {
  	      Siv *sivp= s->getArgSiv();
  	      sivp->Store(ep->mp.evid);;
  	  }
  
  	  if (s->AnotherArg()) {
  	      Siv *sivp= s->getArgSiv();
  	      sivp->Store(ep->etype);
  	  }
  
            if (s->AnotherArg()) {
  	      Siv *sivp= s->getArgSiv();
  	      sivp->Store(ep->woid);
  	  }
  	  
            if (s->AnotherArg()) {
  	      Siv *sivp= s->getArgSiv();
  	      sivp->Store(ep->mp.maw);
  	  }
  
  	   if (s->AnotherArg()) {
  	      Siv *sivp= s->getArgSiv();
  	      sivp->Store(ep->button);
  	  }
  
  	   if (s->AnotherArg()) {
  	      Siv *sivp= s->getArgSiv();
  	      sivp->Store(ep->keyc);
  	  }
  
  	  if (s->AnotherArg()) {
  	      Siv *sivp= s->getArgSiv();
  	      DBP("woproc %s\n",ep->woproc);
  	      sivp->Store(ep->woproc);
  	  }	  	   
  	  
  	   s->result->Store (ev_name(ep->etype));
        }
      }
    else
      return s->result->Store (ev_name(Gev.etype));
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventkey (Siv * sivp, Svarg * s)
  {
    if (s->result != NULL)
    s->result->freeSivMem ();
    
    if (sivp->checkType (GEVENT))
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	{
  	  // DBT ("keyc %c\n", ep->keyc);
  	  s->result->Store (ep->keyc);
  	}
        else
  	{
  	  dberror ("bad event var \n");
  	}
      }
    else
      return s->result->Store (Gev.keyc);
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventkeyw (Siv * sivp, Svarg * s)
  {
     if (s->result != NULL)
    s->result->freeSivMem ();
    if (sivp->getType () == GEVENT)
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	s->result->Store (ep->keyw);
      }
    else
      return s->result->Store (Gev.keyw);
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventwoname (Siv * sivp, Svarg * s)
  {
       if (s->result != NULL)
    s->result->freeSivMem ();
  
    if (sivp->getType () == GEVENT)
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	s->result->Store (ep->woname);
      }
    else
      return s->result->Store ("");
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventwoproc (Siv * sivp, Svarg * s)
  {
       if (s->result != NULL)
    s->result->freeSivMem ();
    DBP("event var %s\n",sivp->getName());
    if (sivp->getType () == GEVENT)
      {
        Asl_event *ep = sivp->getEvent (0);
        DBP("event proc <%s>\n",ep->woproc);
        if (ep != NULL)
  	s->result->Store (ep->woproc);
      }
    else {
      DBP("using last global event Gev!\n");
      return s->result->Store (Gev.woproc);
  
    }
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventwoaw (Siv * sivp, Svarg * s)
  {
    int val = Gev.mp.maw;
  
    if (sivp->getType () == GEVENT)
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	s->result->Store (ep->mp.maw);
      }
    else
  
      return s->result->Store (val);
  }
  
  //[EF]===================================================//
  
  int
  Vmf::geteventwoivalue (Siv * sivp, Svarg * s)
  {
    //  DBT("wo_ival  %d\n",Gev.wo_ival);
    return s->result->Store (Gev.wo_ival);
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventwovalue (Siv * sivp, Svarg * s)
  {
       if (s->result != NULL)
    s->result->freeSivMem ();
    if (sivp->getType () == GEVENT)
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	s->result->Store (ep->wovalue);
      }
  
    return s->result->storeString ("");
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventwoid (Siv * sivp, Svarg * s)
  {
    if (s->result != NULL)
      s->result->freeSivMem ();
    if (sivp->checkType (GEVENT))
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	{
  	  s->result->Store (ep->woid);
  	}
        else
  	{
  	  dberror ("bad event var \n");
  	}
      }
    else
      return s->result->Store (-1);
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventwid (Siv * sivp, Svarg * s)
  {
    if (sivp->checkType (GEVENT))
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	{
  	  Woid woid (ep->woid);
  	  s->result->Store (woid.getWid ());
  	}
        else
  	{
  	  dberror ("bad event var \n");
  	}
      }
    else
      return s->result->Store (-1);
  }
  
  //[EF]===================================================//
  /*
  int
  Vmf::geteventstate (Siv * sivp, Svarg * s)
  {
    /// this prbly obsolete
    if (s->anotherArg ())
      {
        Siv *ev = s->getArgSiv ();
        if (ev != NULL)
  	{
  	  if (ev->checkType (INT) && (ev->getSize () >= 14))
  	    {
  	      int *ip = (int *) ev->Memp ();
  	      for (int i = 0; i < 14; i++)
  		{
  		  ip[i] = Gev.iv[i];
  		  //     DBT("[%d] %d\n",i,ip[i]);
  		}
  	    }
  	}
      }
    return s->result->Store (1);
  }
  */
  //[EF]===================================================//
  int
  Vmf::geteventrinfo (Siv * sivp, Svarg * s)
  {
    /// this prbly obsolete
    if (s->anotherArg ())
      {
        Siv *ev = s->getArgSiv ();
        if (ev != NULL)
  	{
  	  float *fp = (float *) ev->Memp ();
  	  for (int i = 0; i < 10; i++)
  	    fp[i] = Gev.fv[i];
  	}
        return s->result->Store (1);
      }
    else
      {
        float *fp = (float *) s->SetUpResultVec (FLOAT, 12);
        for (int i = 0; i < 10; i++)
  	fp[i] = Gev.fv[i];
      }
    return 1;
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventrxy (Siv * sivp, Svarg * s)
  {
  
    if (sivp->checkType (GEVENT))
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	{
  
  	  if (s->anotherArg ())
  	    {
  	      Siv *rx = s->getArgSiv ();
  	      if (rx != NULL)
  		rx->Store (ep->fv[1]);
  	    }
  	  if (s->anotherArg ())
  	    {
  	      Siv *ry = s->getArgSiv ();
  	      if (ry != NULL)
  		ry->Store (ep->fv[2]);
  	    }
  	}
      }
    return s->result->Store (1);
  }
  
  //[EF]===================================================//
  int
  Vmf::geteventrowcol (Siv * sivp, Svarg * s)
  {
  
    if (sivp->checkType (GEVENT))
      {
        Asl_event *ep = sivp->getEvent (0);
        if (ep != NULL)
  	{
  
  	  if (s->anotherArg ())
  	    {
  	      Siv *rx = s->getArgSiv ();
  	      if (rx != NULL)
  		{
  		  int wrow = (int) ep->fv[8];
  		  rx->Store (wrow);	// which row in spreadsheet
  		}
  	    }
  	  if (s->anotherArg ())
  	    {
  	      Siv *ry = s->getArgSiv ();
  	      if (ry != NULL)
  		{
  		  int wcol = (int) ep->fv[9];
  		  ry->Store (wcol);	// which col in spreadsheet
  		}
  	    }
  	}
      }
  
    return s->result->Store (1);
  }
  
  //[EF]===================================================//
  
  //int Wcomsf::MessageWait (Svarg * s);
  //[EF]===================================================//
  int
  Vmf::waitformsg (Siv * sivp, Svarg * s)
  {
    
    if (s->result != NULL) {
     s->result->freeSivMem ();
    }
    else {
      DBE("svarg result points to  NULL\n");
      
    }
    Wcomsf::MessageWait (s);
  
    if (sivp->setEvent (&Gev))
      {
        return s->result->Store (1);
      }
    else
      return s->result->Store (0);
  }
  
  //[EF]===================================================//
  
  int
  Vmf::readmsg (Siv * sivp, Svarg * s)
  {
    if (s->result != NULL)   
     s->result->freeSivMem ();
    Wcomsf::MessageRead (s);
    if (sivp->setEvent (&Gev))
      {
        return s->result->Store (1);
      }
    else
      return s->result->Store (0);
  }
  
  //[EF]===================================================//
  int
  Vmf::checkkeyw (Siv * sivp, Svarg * s)
  {
    /// this prbly obsolete
    int ok = 0;
  
    if (s->anotherArg ())
      {
        char *cp = s->getArgStr ();
        if (strcmp (cp, Gev.keyw) == 0)
  	ok = 1;
        //DBT("%s keyw %s vs %s match %d\n",Gev.msg,Gev.keyw,cp,ok);
      }
    s->result->Store (ok);
  
    return 1;
  }
  
  //[EF]===================================================//
  
  
  /////////////////////   test set and get internal class - gevent ===========
  
  int
  Vmf::seteventbutton (Siv * sivp, Svarg * s)
  {
    
    if (sivp->checkType (GEVENT))
      {
        Asl_event *ep = sivp->getEvent (0);
  
        if (ep != NULL)
  	{
  	  int b = s->getArgI();
  	  ep->button = b;
  	  // address - offset from object address??
  	  
  	  long addr = (long) &ep->button;
            DBT("addr/offset %d\n",addr);
  	  s->result->Store (addr);
  	}
      }
  
  }
  //[EF]===================================================//
  int
  Vmf::geteventaddrs (Siv * sivp, Svarg * s)
  {
    
    if (sivp->checkType (GEVENT))
      {
        Asl_event *ep = sivp->getEvent (0);
  
        // return ep members addresses
        
        if (ep != NULL)
  	{
  	  void *raddr = s->SetUpResultVec (LONG, 20);
  	  // address - offset from object address??
  	  // use long??
            long *ip = (long *) s->result->Memp ();
  	  
  	  long addr = (long) ep;
  
  	  *ip++ = addr;
  	  *ip++ = (long) &ep->mp; // same as above start of object
  	  *ip++ = (long) (&ep->msg) -addr;
  	  *ip++ = (long) &ep->keyw;
  	   //*ip++ = (long) &ep->ev_type;
  	   *ip++ = (long) &ep->woname;
  	   *ip++ = (long) &ep->woproc;
  	   *ip++ = (long) &ep->wovalue;
             *ip++ = (long) &ep->ev_msg;	   
  	   *ip++ = (long) (&ep->keyc) -addr;
  	   *ip++ = (long) (&ep->etype) -addr;
  	   *ip++ = (long) (&ep->woid) -addr;
  	   *ip++ = (long) (&ep->button) -addr;	  
  	   *ip++ = (long) (&ep->wo_ival) -addr;
  	   *ip++ = (long) (&ep->waw) -addr;
            *ip++ = (long) &ep->rx;
            *ip++ = (long) &ep->ry;	  	  	  
            *ip++ = (long) &ep->nm;	  	  
  	  
  	  DBT("addr/offset %d sizeof(mp) %d \n",addr, sizeof(ep->mp));
  
  	}
      }
    return 1;
   }
  //[EF]===================================================//
  
  int
  Vmf::geteventpars (Siv * sivp, Svarg * s)
  {
    
    if (sivp->checkType (GEVENT))
      {
        int offset  =0;
        long addr = s->getArgL();
        if (s->AnotherArg())
           offset  = s->getArgI();
        
        Asl_event *ep = (Asl_event *) (void *) addr;
  
        // return ep members addresses
        
        if (ep != NULL)
  	{
  
  	  void *raddr = s->SetUpResultVec (INT, 20);
  	  // address - offset from object address??
  	  // use long??
            int *ip = (int *) s->result->Memp ();
  	  DBPF(" %d %d %d\n",ep->etype,ep->button,ep->woid);
  	  *ip++ = ep->etype;
  	  *ip++ = ep->button;
  	  *ip++ = ep->woid;
  	  *ip++ = *(int *) (void *) (addr + offset);
  	}
      }
  
    return 1;
  }
  //[EF]===================================================//
  
 