

Checkin()
setdebug(0)

 xp = 0.9
 yp = -0.3

<<"first entry val  %V $xp $yp \n"
     CheckFNum(xp,0.9,6)
     CheckFNum(yp,-0.3,6)

  yp -= 0.2
  xp += 0.2

CheckFNum(yp,-0.5,6)
CheckFNum(xp,1.1,6)
CheckOut()
;
stop!