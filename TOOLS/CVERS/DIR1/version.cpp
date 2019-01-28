/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/////                                  version.cpp                        
////                                                                       
///        CopyRight   - RootMeanSquare - 1990 -->                 
//         Mark Terry                                                        
/////////////////////////////////////////<v_&_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

#include <gasp-conf.h>
#include <global-funcs.h>
#include <stdio.h>
#include <string.h>
#include <iostream>

char gs_vers[32];

#include "elements.h"

char *
get_gs_version ()
{
  //  v8 --- 02/04/2018
  //  v9 --- 04/28/2018
  //  v10 --- 01/18/2019
  char vers[32];

  int vn = 10;			// 01/18/2019

  strcpy (vers, getElement (vn));
  sprintf (gs_vers, "%s", vers);
  return gs_vers;
}

//============================
/*
 * XASL version 
 *		Window & Menu Manager			     
 *		performs graphic commands given by	     
 *		associated script ASL processes		     
 *	        scripts can perform signal acquisition	     
 *		IPC is via pipes	
 *              graphic commands info via SHM		     
 *	        signal editing and processing	             
 *		X window version runs on SUN OS,             
 *		Solaris, Dec, FreeBsd,BSDI, & Linux          
 *	        Key<->Mouse operations updated Nov 1995      
 *              XW port started 1988->			     
 *		Initial version on MassComp RTU	(igh)    
 *
 * 
 *
 */

/// 02-04-18 ---  gss shet and cell mods - faster display
/// 05-01-17 ---  gwm can now make use of Svar,Siv, Record, List SivArray data structures
///
///
/// 04-26-14 -- reworking comms so that multiple asl clients are handled better
///          -- want to add in socket coms - so that remote asl clients can display
///


// 11/19/09 - do_rsi and associated functions revamp
//            a lot of the do_rsi ASL->GWM function requests now obsoleted
//            since most graphic requests arrive via SHM and do not require any handshakes
//            they are done whenever the GWM gets around to them
//            do_rsi functions (via PIPES) do have handshaking ASL will not move on until handshake is received
//            similarly SRS (send and receive structs) requires handshakes (or times out)
//            SRS sends structure via SHM receives it back via pipe





/* //////////////////////////-Be-////////////////////////////
 *
 * 12-01-16  spreadsheet each cell now a scell class  
 * 04-16-16  spreadsheet wo, wo_text
 * 01-17-16
 * --- sendmsg_w -- send_type_event rework 
 * 04-26-14  reworking env setup screen sizing
 * 06-02-13  rework events, sendmessage, wo funcs
 * 09-18-11  radialpoints
 * //////////////////////////-Be-////////////////////////////
 * 07-19-08  Wscreen info --> asl
 * 06-21-08
 * //////////////////////////-H-////////////////////////////
 * 4-22-08   - wo_graph rework
 * 3-20-07   - wob name -rework
 * 8-16-06   - revised menus, wob functions, spawnasl
 * 6-21-06   - gwm_quad
 * 6-2-06   - WOCLEAR, MouseCursor, wo mouse event
 * 5-4-06   - wob angle
 * 4-30-06   - wob CF_CI
 * 2-04-06   - rework SHM --- threaded version set USE_PLOT_THREAD
 * 1-04-06   - exposure screen fix    
 * 12-25-05  - mods to work with threaded version of asl
 * 2.1.1
 * 9-4-05   axnum rework, new of GSwindow
 * 2.1
 * 2.0
 * **** -      2.0 -  to work with asl 
 * 1.54
 * 10-2-2004 - rework msg - mouse event passing to spi - 
 * 1.53
 * 9-24-2004 - clipline fix - (short,int mismatch)
 * 9-16-2004 - multiple scales for windows
 * 7-24-2004 - DeleteWob fix
 * 5-30-2004 - DRAWTOWINDOW-DRAWTOPIXMAP revise for strings
 * 1.49
 * 4-28-2004 - compatibility with spi gthread
 * 1.48
 * 3-12-2004 - added pan-scales
 * 1.47
 * 5-15-2003 - rework w_set_wo routines
 * 1.46
 * 2-16-2003  - more wo_plot functions 
 * 1.45
 * 1-29-2003  - switchscreen
 * 1.44
 * 1-23-2003  - plothvline
 * 1.43
 * 1-1-2003  - multi-screen
 * 1.42
 * 12-26-2002 - improved rotate code - setrotate to spi plot
 * 12-23-2002 - rotate xyrlt
 * 12-6-2002 - ToolBar
 * 1.41
 * 10-13-2002 - pixmapdraw on off now set via win_dori
 * 9-15-2002 - shared mem now default
 * 1.40
 * 12-20-2001 - revamped shared memory interaction with sip
 * 12-15-2001 - moved ticks,plot_circle interface to sip
 * 1.39
 * 8-24-2001 - moved text -> Text as a GWMGI 
 * 8-22-2001 - added WBSH GWMGI
 * 8-1-2001  - draws can be made to pixmap-allows for animation
 * 7-10-2001 - XGS can be spawned via sip
 * 6-4-2001 - shared memory version - sip puts graphic commands to shared memory
 *          -  xgs reads/executes and tags as done - multiple sip/xgs can be active
 * 1.38
 * 3-27-2000 - C++ version ( just compile- no OO design yet)
 * 1.37
 * 1-7-2000 - ANSI - should catch some bugs
 * 1.36
 * 12-16-99 - set_wof wrong function declaration fixed
 * 1.35
 * 9-3-99 - bug-fix plt_symbol 
 * 9-1-99 - wo_activate sends wo_val wo_name 
 * 1.34
 * 5-16-99 - revised event queque - wait states and read/write on sip pipes
 * 1.33
 * 
 * 2-21-99 - sip_argv now pointers to argv (but don't try to print them if not assigned (in Linux)
 * 2-18-99 - revised win_dori.c -Msg header now contains more info for graphic instructions
 * 1.32
 *                 to sip 
 * used GS_event - to store events, can compose a series of keys to be sent
 * 1.31
 * added GS_event type to hold keyboard events destined for sip applications
 * 1.28
 * 3-15-98  CNTL_T transpose char, CNTRL_B
 * 3-14-98  fixes to win_edit for text editing
 * 1.27 (756573)
 * 3-14-98  bug in gs_wo_func call fix (null window arg)
 * 1.26
 * 2-19-98  using lint to remove unused variables
 * 1.25
 * 2-19-98  added GWM_Box
 * 2-19-98  fix window obscured after navigator
 * 2-10-98  keyboard control navigator
 * 1-15-98  keyboard control menus
 * 12-26-97 help_win controlled via gs_wo_func
 * 12-26-97 added sp,ip,fp wop two to wo struct
 * 1.24
 * 12-16-97 icon resizing original parameters stored in base wo
 * 12-05-97 clip resize
 * 12-07-97 wo_wrt_name
 * 1.23
 * 11-30-97 save_image not releasing pixmap- fixed
 * 1.22
 * 11-24-97 hand_shake check for do_rsi
 * 1.21
 * 11-1-97 reduce CPU polling in xgs
 * 10-29-97 -D on xgs command line - change to directory
 * 1.20
 * 10-23-97 store_wimage bug-fix
 * 1.19
 * 09-29-97 onoff sends mesg
 * 09-25-97 used strsep in win_dori do_rsi
 * 1.18
 * curs_font - keep track and reload previous
 * 08-11-97
 * s_b (select_real - bug-fix)
 * paint_line bug fix
 * 1.15
 * w_show_curs option - no warp
 * 1.14
 * version bug
 * 1.13
 * find_menu 
 * 1.12
 * code_debug - cut down debug statements in journal files to ERRORS and VIS
 * 1.11
 * window delete null pointer bug fix
 * wo delete bug fix
 * menu help print
 * menu double-col fix
 * 1.10
 * 04-03-97 added GWM_WOTEXT
 * 1.9
 * 02-27-97 xgs will make local GASP directory and .gs_alias if not found
 * 02-27-97 getenv GS_SIZE bug
 * 02-24-97 reply line to check wp
 * 02-24-97 warp cursor to Root (0,0) and then xgs window to focus
 * 1.8
 * 02-12-97 fixed menu-width bug
 * 02-10-97 added menu ? - calls query_w as a choice option - menu_int.c
 * 02-04-97 PS_Plot_CVX(px,s,k,np) postscript image
 * 01-21-97 set wo's in navi_win NOT to send messages to sip
 * 1.7
 * 01-06-97 added navi_win for file/directory listing
 * plot_symbol clips to clip-window
 * 1.6
 * 11-25-96 v key gives version 
 * 11-25-96 fixed error_win bug 
 * 26-Sep-96 fixed rescale wop/wop_mods.c 
 * Mar- July 96 various dbugs 
 * 2-Mar-96 fixed clip-clear gwm/win_ops.c 
 */

void
show_version ()
{
  std::cout << get_gs_version () << "\n";
}

///////////////////  UNDEF REFS /////







//////////////////  TBD////////////////////////
//
//  Need to revise window overlapping displays - currently display does not
//  work correctly if windows overlap
//  socket comms
//
//
//
//
//
//
//
//
//
//
//
//
