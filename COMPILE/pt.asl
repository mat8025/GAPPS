///
///
///


  //Str ele = "Pr";
Siv ele(STRV);

  ele = "Dy";
  
cout << " in pt.asl A " << A << " ele " << ele  << endl;


Str t;

Str r;

   t = "uno ";
   r = "dos ";

   char FMT[256];

   FMT[0] = '\0';

 strcat(FMT,typeid(t).name());
    strcat(FMT,",");
    strcat(FMT,typeid(r).name());
    strcat(FMT,",");    
    printf("FMT %s\n",FMT);

   ele =cpp2asl ("scat",FMT,&t,&r);

cout << " in pt.asl t " << t << " ele " << ele  << endl;
 FMT[0] = '\0';
    strcat(FMT,typeid(A).name());
    printf("FMT %s\n",FMT);




 ele = cpp2asl ("pt",FMT,A);


cout << " in pt.asl A " << A << " ele " << ele  << endl;
 A++;
 ele = cpp2asl ("pt",FMT,A);


cout << " in pt.asl A " << A << " ele " << ele  << endl;

int ok;
    ok=mod_wo(1,MWO_BORDER, BLACK_,MWO_COLOR, RED_,MWO_LAST);
    //ok=mod_wo(1,MWO_BORDER, MWO_COLOR, RED_);


cout << " in pt.asl ok " << ok << RED_  << endl;
