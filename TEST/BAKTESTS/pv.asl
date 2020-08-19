setdebug(0)
proc ra(v)
{
<<"$_proc IN $v \n"
int ln = 2
  v++
  ln++
<<"%V $v $ln \n"
<<"$_proc OUT $v \n"
}

int n = 2
<<"%V $n \n"
    n++
<<"%V $n \n"


<<"pre call %V $n \n"

  ra(n)

<<"post call %V $n \n"


stop!