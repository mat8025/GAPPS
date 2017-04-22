///
/// upe_menu
///


proc the_menu (the_choice)
{
        <<" $the_choice \n"

        // TBD show_curs(1,-1,-1,"watch")

        if ( the_choice @= "REDRAW") {
            show_curs(1,-1,-1,"cross",7,7)
            return 1
	      }



	if (  the_choice @= "ADD" ) {
                add_some_tokens()
                 return 1
		  }

	if (  the_choice @= "DEL" ) {
	    do_delete(tok_type)
            return 1
	}


	if (  the_choice @= "RENAM" ) {
	    do_rename(tok_type)
            return 1
	}

	if ( the_choice @= "SEL" ) {
            showVox(two, ss1, ss2);
	    ss1 += 1000;
	    ss2 += 1000;
	    
            // TBD do_a_select()
            return 1;
	}

	if ( the_choice @= "PLAY" ) {
	    play_the_signal(sp1,sp2)
            return 1
        }

	if ( the_choice @= "SG" ) {
              show_sg()
              return 1	
	}

	if (  the_choice @= "RMS_ZX" ) {
		show_rms() 
              return 1	
	}

	if ( the_choice @= "P_TOK" ) {
		play_token(timit_gp)
               return 1
	}

	if ( the_choice @= "P_WORD" ) {
		play_token(timit_w)
              return 1
	}

	if ( the_choice @= "P_L" ) {
		paint_the_labels()
              return 1
	}


	if (  the_choice @= "FORW" ) {
                   go_forward()
                   return 1;
		}

	if ( the_choice @= "REV" ) {
                   go_back()
                   return 1;
	}

	if ( the_choice @= "FILE" ) {
                   new_file()
                   return 1
		}

	if ( the_choice @= "EXIT" ) {
                   do_exit()
                   return 1
	   }

	if ( the_choice @= "<->" ) {
                zoom_out()
                return 1
	}

	if ( the_choice @= "SR" ) {
		zoom_in()
                return 1
	}

	if (the_choice @= "WRITE") {
                 write_tokens()
               return 1
	}


}
//=================================================





proc do_exit()
{

		exitgs();
/{		
         op = decision_w("EXIT","exit  "," yes ", " no ")
	 if (op @= "yes") {
                show_curs(1,-1,-1,"cross",7,7)

		exit()
		}
/}
}
//===============================================
proc zoom_out()
{
		w_clip_clear(tw)
		read_the_signal(0,Endtime,0)
		paint_the_labels()
}
//===============================================
proc zoom_in()
{
            z1 = get_srs(pw)
            z2 = get_srf(pw)
	    do_zoom(z1,z2)

}
//===============================================
proc do_a_select()
{
	 w_show_curs(pw,1,"right_arrow",0.5,0.5)
	 did_sr=mouse_select(pw)
         if (did_sr) {
	 do_zoom(Z0,Z1)
         }
#	 w_real_xor(pw,Z0,0,Z1,400)
}
//===============================================