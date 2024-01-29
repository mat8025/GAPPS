///
///
///


//  what words can we spell with Element Symbols

/*
 I 53
 Snag 5047
 iron 7787
 poof 84 8 8 9
 Nag  7 47
 close 17 8 34
 pair  91 77
 pace  91 58
 bite  83 52
 woof  74 8  8 9
 At    85
 coat  2785
 feat 26 85
 cute 29 85
 beat  5 85
 acute 89 92 52 Ac U Te

 dict acute > word_check 2>&1


5 definitions found

From The Collaborative International Dictionary of English v.0.48 [gcide]:

  Acute \A*cute"\, a. [L. acutus, p. p. of acuere to sharpen, fr.
     a root ak to be sharp. Cf. {Ague}, {Cute}, {Edge}.]
     1. Sharp at the end; ending in a sharp point; pointed; --
        opposed to {blunt} or {obtuse}; as, an acute angle; an
        acute leaf.
        [1913 Webster]
  
     2. Having nice discernment; perceiving or using minute
        distinctions; penetrating; clever; shrewd; -- opposed to
        {dull} or {stupid}; as, an acute observer; acute remarks,
        or reasoning.
        [1913 Webster]
  
     3. Having nice or quick sensibility; susceptible to slight
        impressions; acting keenly on the senses; sharp; keen;
        intense; as, a man of acute eyesight, hearing, or feeling;
        acute pain or pleasure.
        [1913 Webster]
  
     4. High, or shrill, in respect to some other sound; --
        opposed to {grave} or {low}; as, an acute tone or accent.
        [1913 Webster]
  
     5. (Med.) Attended with symptoms of some degree of severity,
        and coming speedily to a crisis; -- opposed to {chronic};
        as, an acute disease. AS
        [1913 Webster]
  */

#include "debug"

if (_dblevel >0) {
   debugON()
   
}

allowErrors(-1) ; // keep going


    !!"grep  --regex ^hotel\$ /usr/share/dict/words >word_check" 

 !!" head -10 word_check"

    sz= fexist("word_check",0,4)
   //     sz2= fexist("chem.asl",0,4)
//	        sz3= fexist("chem7.asl",0,4)
  // ans=ask("%V  $sz $sz2 $sz3 ynq [y]\n",1)


Str pre;
Str mid;
Str end;
int len;
A=ofw("pt_dict_3ele")
wcnt=0
  for (i = 1; i <=100; i++) {
      pre = ptsym(i)
<<"////////////////////\n$i   $pre \n\\\\\\\\\\\\\\\n"

   for (m = 1; m <= 100 ; m++) {
       mid =  ptsym(m)

   for (j = 1; j <= 100 ; j++) {
       end =  ptsym(j)

    word = scat(pre,mid,end);
    len = slen(word)
    ccnt = ccon(word);
    cvow = cvow(word);
    ptword = slower(word)
    //
    //!!" dict $word > word_check 2>&1 "
    
   // !!"grep  --regex ^$ptword\$ /usr/share/dict/words > ${wcnt}_word_check"
    !!"grep  --regex ^$ptword\$ /usr/share/dict/words > word_check" 
   //
   <<"\r$i $m $j  "
    fflush(1)
    sz= fexist("word_check",0)
    if (sz > 2 && (ccnt < len)) {
    <<"\r$wcnt $i $m $j $len $ccnt $cvow <|$word|> \n"
    
    <<[A]"$ptword $i $m $j  \n"    
//!!" head -1 word_check"
     //ans=ask(" $(slower(word))  $sz  ynq [y]\n",1)
     wcnt++
    
    }
    }
   }
//   if (wcnt > 1000)      break
  }


cf(A)