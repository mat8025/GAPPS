
atn = _argv[1]
//<<" number ? $atn\n"

if (isanumber(atn)) {
  <<"yes number $atn \n"
  num = atoi(atn)
  b = pt(num)
}
else 
  b = pt(atn)

<<"$b\n"