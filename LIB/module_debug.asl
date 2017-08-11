#! asl
# "$Id: module_debug.g,v 1.1 1999/09/15 16:12:08 mark Exp mark $"

  if (Main_init) {
  DB = 1
  DBPE = 1
  Debug = "OFF"
  name_debug("PROC_ENTRY","PROC_ARGS",1)
  }

proc reload_modules()
{
 <<"reloading modules \n"
 reload_src(1)
}

proc error_exit(msg)
{
  err = si_error()
  errname=get_si_error_name()
  errfunc=get_si_error_func()
  errlnum=get_last_call()
  << "$0  last error $err $errname $errfunc @ $errlnum : $msg \n"
  set_si_error(1)
  ff=exit_si()
}

