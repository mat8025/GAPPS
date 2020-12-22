

Checkin()
sdb(1,@pline)

 xp = 0.9
 yp = -0.3

<<"first entry val  %V $xp $yp \n"
     chkR(xp,0.9,6)
     chkR(yp,-0.3,6)

  yp -= 0.2
  xp += 0.2

chkR(yp,-0.5,6)
chkR(xp,1.1,6)
chkOut()
