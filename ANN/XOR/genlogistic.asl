///
///  generate hyperbolic activation function
///



proc hyperactiv (hya)
{
  hyae = (2.0 / (1.0 + exp (-2.0 * hya)) - 1.0);
  //<<"$_proc %v$hya $hyae\n"
 return  hyae
}

proc logistic (ex)
{
  out = (1.0 / (1.0 + exp (-ex)));
  return out;
}



range = 10.0;

   for (x = -range ; x < range ; x += 0.1) {

 //     y=hyperactiv (x);
      y=logistic (x);

<<"$x, $y \n"

   }