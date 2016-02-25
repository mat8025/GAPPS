
proc p2c(pa)
{
  ca = pa - 450

  if (ca < 0.0)
   ca *= -1

//   ca = fmod(ca, 360)

  if (ca > 360)
     ca -= 360

  return ca

}

float ipa

  for (ipa = 0.0 ; ipa <= 360.0; ipa += 10.0) {
      ang = p2c(ipa)

  <<" $ipa --> $ang \n"

  }


;