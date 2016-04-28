
///
///
///

/// extract the channels from ceppt output

setDebug(1)
fname = _clarg[1];
 chn = 0;
  na = argc();
 if (na > 1) {
  chn = atoi(_clarg[2])
 }

//float FV[];

if (chn >= 0) {
 Vec=readChannel(fname,chn,0)

<<"%(5,\s, ,\n)$Vec "

sz = Caz(Vec)
<<"%V$sz\n"
}
