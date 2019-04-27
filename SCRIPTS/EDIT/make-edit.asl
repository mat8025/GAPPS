

while (1) {
L=readline(0)
iv=sstr(L,"= ../../lib")
if (iv[0] == -1) {
<<"$L\n"
}
else {
<<"gasp_sys = /usr/local/GASP\n"
<<"gslibdir = \$(gasp_sys)/lib\n"

}



if (feof(0))
  break


}