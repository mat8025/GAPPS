
int ht
 ht = 0x40
 
<<"$ht  %x $ht\n"

        defin = 0
	devdata = 0;

      ct= ht & 0x80
 
   <<"%V $ht 0x80 %X $ct $ht\n"

   ct= ht & 0x40
   <<"%V $ht 0x40 %X $ct $ht\n"

if ((ht & 0x40) == 0x40) {
   <<"$ht %x $ht == 0x40\n"
        defin = 1
}

   ct= ht & 0x20
   <<"%V $ht 0x20 %X $ct $ht\n"

if ((ht & 0x20) == 0x20) {
        <<"$ht %x $ht == 0x20 ?\n"
	devdata = 1;
}

<<"%V $defin $devdata\n"