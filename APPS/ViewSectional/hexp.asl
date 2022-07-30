///
///
///

uint TV[10]



TV[1] = 1
TV[2] = 256
TV[3] = 2^16 +1
TV[4] = 10
TV[5] = hex2dec("ffaabbcc");

TV[6] = hex2dec("cc");
TV[7] = hex2dec("abcc");
TV[8] = hex2dec("abcc00");
TV[9] = hex2dec("000000ff");

for (i=0;i<10;i++) {
printf('%d %.8x\n',i,TV[i]);
<<"$i %.8x $TV[i] \n"
}