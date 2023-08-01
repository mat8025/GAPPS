/* 
 *  @script consts.asl                                                  
 * 
 *  @comment set some useful constants                                  
 *  @release Fluorine                                                   
 *  @vers 1.2 He Helium [asl 5.9 : B F]                                 
 *  @date 08/01/2023 08:03:27                                           
 *  @cdate Fri Apr 17 21:09:27 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 



// define some Constants
//<<" calc ap E \n"



const double E_ = exp(1.0);

<<"Loading $E_ !\n"


const double G_ = 6.672e-11

const double g_ = 9.8 // m per sec per sec -- grav acc

const double c_ = 299792458;  // m per sec

const double sos_ = 331.0 // m per sec 

const double k_ = 1.38070e-23


const double h_ = 6.626e-34;

const double eV_ = 1.602e-29;


const double EarthRadius_ = 6371000.0 //  6371 km

const int EarthDay_ = (24 * 60 *60) 

//<<"%v  $EarthDay secs\n"

const double EarthSun_ = 1.496e11  // meters AU 146 - 152  million km

const double EarthMoon_ = 3.84e8  // meters

const double SunMass_ = 2.0e30

const double EarthMass_ = 5.980e24

const double Avogadro_ = 6.022140e23



<<"%v $EarthMass_ \n"

# wt in dynes

//grain = 63.57
//oz_avoir = 2.78 * pow(10,4)


# unit conversion

# use underscore as prefix character avoid user name conflict

const float inch2cm_ = 2.54
const float ft2m_ = 12*2.54/100.0
const float cm2inch_ = 1.0/inch2cm_
const float m2ft_ = 3.280839
const float mile2km_ = 1.6093
//const float _km2mile = 1.0/ _mile2km   // BUG
const float km2mile_ = 1.0/ 1.6093
const float km2nm_ = 1.0/1.852
const float usgal2liter_ = 3.78541178
const float gal2liter_ = 4.546
const float oz2gram_ = 28.35
const float lb2kg_ = 0.4536
const float kg2lb_ = 2.204586
const float cuft2cum_ = 0.0283

const float  troyoz2gram_ = 31.103
const float  tbspcup_ = 16;
const float  tsptbsp_ = 3;

//<<" %v $troyounce2gram_ = 31.103 \n"

const float  sqmile2acre_ = 259.0/0.4047
const float  knots2mph_ = 6080.0/5280.0
const float  nm2mile_ = 6076.0/5280.0
const float  nm2ft_ = 6076.0
const float  nm2km_ = 1.852
const float  mile2nm_ = 5280.0/6076
const float  mph2knots_ = 5280.0/6076.0
const float  atm2Nm2_ = 1.01e5
const float  atm2lbft2_ = 2116.0
const float  slug2lb_ = 32.2
const float  lightyr_ = 9.46e15


void units()
{
<<"%V$inch2cm_ \n"
<<"%V$ft2m_ \n"
<<"%V$cm2inch_ \n"
<<"%V$mile2km_ \n"
<<"%V$nm2mile_ \n"
<<"%V$mile2nm_ \n"
<<"%V$mph2knots_ \n"
<<"%V$km2mile_ \n"
<<"%V$m2ft_ \n"
<<"%V$nm2ft_ \n"
<<"%V$nm2km_ \n"
<<"%V$usgal2liter_ \n"
<<"%V$gal2liter_ \n"
<<"%V$oz2gram_ \n"
<<"%V$lb2kg_ \n"
<<"%V$kg2lb_ \n"
<<"%V$cuft2cum_ \n" 
<<"%V$troyoz2gram_ \n"
<<"%V$sqmile2acre_ \n"
<<"%V$knots2mph_ \n"
<<"%V$atm2Nm2_ \n"
<<"%V$slug2lb_ \n"
<<"%V$lightyr_ \n"
}

<<"   formats in sci format \%e e.g.  1.38e-23 \n"
void consts()
{
<<"MKS  - note consts are preceeded by underscore \n"
<<"%V$PI_ \n"
<<"%V$E_ \n"
<<"%V$g_  grav acceleration meters per sec per sec \n"
<<"%V %e$G_ Gravitational Constant 6.672 x 10E-11 Nm^2/Kg^2  \n"
<<"%V %e$c_ speed of light    m/s\n"
<<"%V$sos_ speed of sound (Air 0 deg C m/s) \n"
<<"%V%e$k_ Boltzman_ = 1.3807 * 10^-23 J/K \n"
<<"%V%e$h_ Planck_ = 6.626 * 10^-34 J-s \n"
<<"%V%e$eV_ Electron Volt 1.602 x 10^-19 J %Ve$eV_ \n"
<<"%V$EarthRadius_  meters \n"
<<"%V%e$EarthMass_ Kg\n"
<<"%V%e$Avogadro_ entities per mole\n"

<<"\n"

}



//<<"loaded consts and units conversion scalars \n"
//<<" units() -- prints out conversions\n"
//<<" consts() -- prints out known constants\n"

//======================================================