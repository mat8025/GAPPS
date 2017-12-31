# consts.asl
// edit to expand constants units
//setap(50)

//setap(10)

# define some Constants
//<<" calc ap E \n"

const double _E = exp(1.0);

// _PI already known

//<<" $PI_ \n"

const double _G = 6.672e-11

const double _g = 9.8 // m per sec per sec -- grav acc

const double _c = 299792458;  // m per sec

const double _sos = 331.0 // m per sec 

//const double _k = 1.38070e-23
const double _k = 1.38070 * 10^^-23;

//<<"%Ve$_k\n"

const double _h = 6.626e-34;

const double _eV = 1.602e-29;


const double _EarthRadius = 6371000.0 //  6371 km

const int _EarthDay = (24 * 60 *60) 

//<<"%v  $EarthDay secs\n"

const double _EarthSun = 1.496e11  // meters AU 146 - 152  million km

const double _EarthMoon = 3.84e8  // meters

const double _SunMass = 2.0e30

const double _EarthMass = 5.980e24

const double _Avogadro = 6.022140e23



//<<"%v $EarthMass \n"

# wt in dynes

//grain = 63.57
//oz_avoir = 2.78 * pow(10,4)

# unit conversion

# use underscore as prefix character avoid user name conflict

const float _inch2cm = 2.54
const float _ft2m = 12*2.54/100.0
const float _cm2inch = 1.0/_inch2cm
const float _m2ft = 3.280839
const float _mile2km = 1.6093
const float _km2mile = 1/_mile2km
const float _km2nm = 1.0/1.852
const float _usgal2liter = 3.78541178
const float _gal2liter = 4.546
const float _oz2gram = 28.35
const float _lb2kg = 0.4536
const float _kg2lb = 2.204586
const float _cuft2cum = 0.0283

const float _troyoz2gram = 31.103

//<<" %v $troyounce2gram = 31.103 \n"

const float _sqmile2acre = 259.0/0.4047
const float _knots2mph = 6080.0/5280.0
const float _nm2mile = 6076.0/5280.0
const float _nm2ft = 6076.0
const float _nm2km = 1.852
const float _mile2nm = 5280.0/6076
const float _mph2knots = 5280.0/6076.0
const float _atm2Nm2 = 1.01e5
const float _atm2lbft2 = 2116.0
const float _slug2lb = 32.2
const float _lightyr = 9.46e15


proc units()
{
<<"%V$_inch2cm \n"
<<"%V$_ft2m \n"
<<"%V$_cm2inch \n"
<<"%V$_mile2km  \n"
<<"%V$_nm2mile \n"
<<"%V$_mile2nm \n"
<<"%V$_mph2knots \n"
<<"%V$_km2mile  \n"
<<"%V$_m2ft \n"
<<"%V$_nm2ft \n"
<<"%V$_nm2km \n"
<<"%V$_usgal2liter \n"
<<"%V$_gal2liter  \n"
<<"%V$_oz2gram  \n"
<<"%V$_lb2kg  \n"
<<"%V$_kg2lb  \n"
<<"%V$_cuft2cum \n" 
<<"%V$_troyoz2gram  \n"
<<"%V$_sqmile2acre  \n"
<<"%V$_knots2mph  \n"
<<"%V$_atm2Nm2  \n"
<<"%V$_slug2lb  \n"
<<"%V$_lightyr \n"
}


proc consts()
{
//<<"typically MKS  - note consts are preceeded by underscore e.g.speed of light  _c \n"
<<"%V$_PI \n"
<<"%V$_E \n"
<<"%V$_g  grav acceleration meters per sec per sec \n"
<<"%Ve$_G Gravitational Constant 6.672 x 10E-11 Nm^2/Kg^2  \n"
<<"%Ve$_c speed of light    m/s\n"
<<"%V$_sos speed of sound (Air 0 deg C m/s) \n"
<<"%Ve$_k Boltzman = 1.3807 * 10^-23 J/K \n"
<<"%Ve$_h Planck = 6.626 * 10^-34 J-s \n"
<<"%Ve$_eV Electron Volt 1.602 x 10^-19 J %Ve$_eV \n"
<<"%V$_EarthRadius  meters \n"
<<"%Ve$_EarthMass Kg\n"
<<"%Ve$_Avogadro entities per mole\n"

<<"\n"

}


//<<"loaded consts and units conversion scalars \n"
//<<" units() -- prints out conversions\n"
//<<" consts() -- prints out known constants\n"


proc ll2dd (the_ang)
{
      //<<"in CMF GetDeg $the_ang\n"
      //<<"input args is $the_ang \n"

    the_dir="" ;

    float la

     //  <<" $the_ang  \n"
	

    the_parts = Split(the_ang,",")

    //  <<"%V$the_parts \n"

    the_deg = atof(the_parts[0])



    the_min = atof(the_parts[1])

    //<<"%V$the_deg $the_min \n"

    sz= Caz(the_min)

      //<<" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

    the_dir = the_parts[2]

    y = the_min/60.0

    la = the_deg + y

   //<<"%V$the_dir $(typeof(the_dir)) \n"


   if (the_dir @= "N") {
         la *= 1
   }
   else if (the_dir @= "E") {
         la *= 1
   }

   else if (the_dir @= "W") {
         la *= -1
   }

   else if (the_dir @= "S") {
         la *= -1
   }

   //<<" %V$la  $y $(typeof(la)) $(Cab(la)) \n"
      
    return (la)
}

//======================================================