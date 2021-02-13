/* 
 *  @script howfar.asl 
 * 
 *  @comment test some nav functions 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.7 C-Li-N]                                  
 *  @date Wed Jan  6 09:31:44 2021 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */


#include "debug"

//debugON()

allowErrors(-1)

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(REJECT_,"args_process","ds_storestr","scope_e","array_parse");
filterFuncDebug(REJECT_,"checkOffSet");

#include "consts"

<<"%V $_km2mile \n"

//  nashville  N 36 7.2   W 86 40.2
//  los angeles N 33 56.4   W 118 24.0
do_query = 0;

//Berlin="Germany	52	30 N	13	25 E	6:00 p.m."
Svar City


City->table("HASH",977,2) //



//City	°	'	°	'	Time
// m.1 means On the following day.
index= City->addkeyval("Aberdeen","Scotland	57	9 N	2	9 W	5:00 p.m.");
key = "Aberdeen";
val = City->lookup(key)
<<"$index $key  $val\n"
!p index
index= City->addkeyval("Adelaide", "Australia	34	55 S	138	36 E	2:30 a.m.1");
key = "Adelaide";
val2 = City->lookup(key)
<<"$index $key  $val2\n"
index= City->addkeyval("Algiers", "Algeria	36	50 N	3	0 E	6:00 p.m.");
key = "Algiers";
val = City->lookup(key)
<<"$index $key  $val\n"

index= City->addkeyval("Amsterdam", "Netherlands	52	22 N	4	53 E	6:00 p.m.");
key = "Amsterdam";
val = City->lookup(key)
<<"$index $key  $val\n"
index= City->addkeyval("Ankara", "Turkey	39	55 N	32	55 E	7:00 p.m.");
key = "Ankara";
val = City->lookup(key)
<<"$index $key  $val\n"
index= City->addkeyval("Asunción", "Paraguay	25	15 S	57	40 W	1:00 p.m.");
key = "Asunción";
val = City->lookup(key)
<<"$index $key  $val\n"
index= City->addkeyval("Athens", "Greece	37	58 N	23	43 E	7:00 p.m.");
key = "Athens";
val = City->lookup(key)
<<"$index $key  $val\n"

index= City->addkeyval("Auckland", "New Zealand	36	52 S	174	45 E	5:00 a.m.1");
key = "Auckland";
val = City->lookup(key)

<<"$index $key  $val\n"

index= City->addkeyval("Bangkok", "Thailand	13	45 N	100	30 E	midnight");
key = "Bangkok";
val = City->lookup(key)
<<"$index $key  $val\n"





index= City->addkeyval("Barcelona", "Spain	41	23 N	2	9 E	6:00 p.m.");
index= City->addkeyval("Beijing", "China	39	55 N	116	25 E	1:00 a.m.1");
index= City->addkeyval("Belém", "Brazil	1	28 S	48	29 W	2:00 p.m.");
index= City->addkeyval("Belfast", "NorthernIreland	54	37 N	5	56 W	5:00 p.m.");
index= City->addkeyval("Belgrade", "Serbia	44	52 N	20	32 E	6:00 p.m.");
index= City->addkeyval("Berlin", "Germany	52	30 N	13	25 E	6:00 p.m.");
index= City->addkeyval("Birmingham", "England	52	25 N	1	55 W	5:00 p.m.");
index= City->addkeyval("Bogotá", "Colombia	4	32 N	74	15 W	12:00 noon");
index= City->addkeyval("Bombay", "India	19	0 N	72	48 E	10:30 p.m.");
index= City->addkeyval("Bordeaux", "France	44	50 N	0	31 W	6:00 p.m.");
index= City->addkeyval("Bremen", "Germany	53	5 N	8	49 E	6:00 p.m.");
index= City->addkeyval("Brisbane", "Australia	27	29 S	153	8 E	3:00 a.m.1");
index= City->addkeyval("Bristol", "England	51	28 N	2	35 W	5:00 p.m.");
index= City->addkeyval("Brussels", "Belgium	50	52 N	4	22 E	6:00 p.m.");
index= City->addkeyval("Bucharest", "Romania	44	25 N	26	7 E	7:00 p.m.");
index= City->addkeyval("Budapest", "Hungary	47	30 N	19	5 E	6:00 p.m.");
index= City->addkeyval("Buenos Aires", "Argentina	34	35 S	58	22 W	2:00 p.m.");
index= City->addkeyval("Cairo", "Egypt	30	2 N	31	21 E	7:00 p.m.");
index= City->addkeyval("Calcutta", "India	22	34 N	88	24 E	10:30 p.m.");
index= City->addkeyval("Canton", "China	23	7 N	113	15 E	1:00 a.m.1");
index= City->addkeyval("Cape Town", "South Africa	33	55 S	18	22 E	7:00 p.m.");
index= City->addkeyval("Caracas", "Venezuela	10	28 N	67	2 W	1:00 p.m.");
index= City->addkeyval("Cayenne", "French Guiana	4	49 N	52	18 W	2:00 p.m.");
index= City->addkeyval("Chihuahua", "Mexico	28	37 N	106	5 W	10:00 a.m.");
index= City->addkeyval("Chongqing", "China	29	46 N	106	34 E	1:00 a.m.1");
index= City->addkeyval("Copenhagen", "Denmark	55	40 N	12	34 E	6:00 p.m.");
index= City->addkeyval("Córdoba", "Argentina	31	28 S	64	10 W	2:00 p.m.");
index= City->addkeyval("Dakar", "Senegal	14	40 N	17	28 W	5:00 p.m.");
index= City->addkeyval("Darwin", "Australia	12	28 S	130	51 E	2:30 a.m.1");
index= City->addkeyval("Djibouti", "Djibouti	11	30 N	43	3 E	8:00 p.m.");
index= City->addkeyval("Dublin", "Ireland	53	20 N	6	15 W	5:00 p.m.");
index= City->addkeyval("Durban", "SouthAfrica	29	53 S	30	53 E	7:00 p.m.");
index= City->addkeyval("Edinburgh", "Scotland	55	55 N	3	10 W	5:00 p.m.");
index= City->addkeyval("Frankfurt", "Germany	50	7 N	8	41 E	6:00 p.m.");
index= City->addkeyval("Georgetown", "Guyana	6	45 N	58	15 W	1:00 p.m.");
index= City->addkeyval("Glasgow", "Scotland	55	50 N	4	15 W	5:00 p.m.");
index= City->addkeyval("Guatemala City", "Guatemala	14	37 N	90	31 W	11:00 a.m.");
index= City->addkeyval("Guayaquil", "Ecuador	2	10 S	79	56 W	12:00 noon");
index= City->addkeyval("Hamburg", "Germany	53	33 N	10	2 E	6:00 p.m.");
index= City->addkeyval("Hammerfest", "Norway	70	38 N	23	38 E	6:00 p.m.");
index= City->addkeyval("Havana", "Cuba	23	8 N	82	23 W	12:00 noon");
index= City->addkeyval("Helsinki", "Finland	60	10 N	25	0 E	7:00 p.m.");
index= City->addkeyval("Hobart", "Tasmania	42	52 S	147	19 E	3:00 a.m.1");
index= City->addkeyval("Hong Kong", "China	22	20 N	114	11 E	1:00 a.m.1");
index= City->addkeyval("Iquique", "Chile	20	10 S	70	7 W	1:00 p.m.");
index= City->addkeyval("Irkutsk", "Russia	52	30 N	104	20 E	1:00 a.m.");
index= City->addkeyval("Jakarta", "Indonesia	6	16 S	106	48 E	midnight");
index= City->addkeyval("Johannesburg", "South Africa	26	12 S	28	4 E	7:00 p.m.");
index= City->addkeyval("Kingston", "Jamaica	17	59 N	76	49 W	12:00 noon");
index= City->addkeyval("Kinshasa", "Congo	4	18 S	15	17 E	6:00 p.m.");
index= City->addkeyval("Kuala Lumpur", "Malaysia	3	8 N	101	42 E	1:00 a.m.1");
index= City->addkeyval("La Paz", "Bolivia	16	27 S	68	22 W	1:00 p.m.");
index= City->addkeyval("Leeds", "England	53	45 N	1	30 W	5:00 p.m.");
index= City->addkeyval("Lima", "Peru	12	0 S	77	2 W	12:00 noon");
index= City->addkeyval("Lisbon", "Portugal	38	44 N	9	9 W	5:00 p.m.");
index= City->addkeyval("Liverpool", "England	53	25 N	3	0 W	5:00 p.m.");
index= City->addkeyval("London", "England	51	32 N	0	5 W	5:00 p.m.");
index= City->addkeyval("Lyons", "France	45	45 N	4	50 E	6:00 p.m.");
index= City->addkeyval("Madrid", "Spain	40	26 N	3	42 W	6:00 p.m.");
index= City->addkeyval("Manchester", "England	53	30 N	2	15 W	5:00 p.m.");
index= City->addkeyval("Manila", "Philippines	14	35 N	120	57 E	1:00 a.m.1");
index= City->addkeyval("Marseilles", "France	43	20 N	5	20 E	6:00 p.m.");
index= City->addkeyval("Mazatlán", "Mexico	23	12 N	106	25 W	10:00 a.m.");
index= City->addkeyval("Mecca", "Saudi Arabia	21	29 N	39	45 E	8:00 p.m.");
index= City->addkeyval("Melbourne", "Australia	37	47 S	144	58 E	3:00 a.m.1");
index= City->addkeyval("Mexico City", "Mexico	19	26 N	99	7 W	11:00 a.m.");
index= City->addkeyval("Milan", "Italy	45	27 N	9	10 E	6:00 p.m.");
index= City->addkeyval("Montevideo", "Uruguay	34	53 S	56	10 W	2:00 p.m.");
index= City->addkeyval("Moscow", "Russia	55	45 N	37	36 E	8:00 p.m.");
index= City->addkeyval("Munich", "Germany	48	8 N	11	35 E	6:00 p.m.");
index= City->addkeyval("Nagasaki", "Japan	32	48 N	129	57 E	2:00 a.m.1");
index= City->addkeyval("Nagoya", "Japan	35	7 N	136	56 E	2:00 a.m.1");
index= City->addkeyval("Nairobi", "Kenya	1	25 S	36	55 E	8:00 p.m.");
index= City->addkeyval("Nanjing (Nanking)", "China	32	3 N	118	53 E	1:00 a.m.1");
index= City->addkeyval("Naples", "Italy	40	50 N	14	15 E	6:00 p.m.");
index= City->addkeyval("New Delhi", "India	28	35 N	77	12 E	10:30 p.m.");
index= City->addkeyval("Newcastle-on-Tyne", "England	54	58 N	1	37 W	5:00 p.m.");
index= City->addkeyval("Odessa", "Ukraine	46	27 N	30	48 E	7:00 p.m.");
index= City->addkeyval("Osaka", "Japan	34	32 N	135	30 E	2:00 a.m.1");
index= City->addkeyval("Oslo", "Norway	59	57 N	10	42 E	6:00 p.m.");
index= City->addkeyval("Panama City", "Panama	8	58 N	79	32 W	12:00 noon");
index= City->addkeyval("Paramaribo", "Suriname	5	45 N	55	15 W	2:00 p.m.");
index= City->addkeyval("Paris", "France	48	48 N	2	20 E	6:00 p.m.");
index= City->addkeyval("Perth", "Australia	31	57 S	115	52 E	1:00 a.m.1");
index= City->addkeyval("Plymouth", "England	50	25 N	4	5 W	5:00 p.m.");
index= City->addkeyval("Port Moresby", "Papua New Guinea	9	25 S	147	8 E	3:00 a.m.1");
index= City->addkeyval("Prague", "Czech Republic	50	5 N	14	26 E	6:00 p.m.");
index= City->addkeyval("Rangoon", "Myanmar	16	50 N	96	0 E	11:30 p.m.");
index= City->addkeyval("Reykjavík", "Iceland	64	4 N	21	58 W	5:00 p.m.");
index= City->addkeyval("Rio de Janeiro", "Brazil	22	57 S	43	12 W	2:00 p.m.");
index= City->addkeyval("Rome", "Italy	41	54 N	12	27 E	6:00 p.m.");
index= City->addkeyval("Salvador", "Brazil	12	56 S	38	27 W	2:00 p.m.");
index= City->addkeyval("Santiago", "Chile	33	28 S	70	45 W	1:00 p.m.");
index= City->addkeyval("St. Petersburg", "Russia	59	56 N	30	18 E	8:00 p.m.");
index= City->addkeyval("São Paulo", "Brazil	23	31 S	46	31 W	2:00 p.m.");
index= City->addkeyval("Shanghai", "China	31	10 N	121	28 E	1:00 a.m.1");
index= City->addkeyval("Singapore", "Singapore	1	14 N	103	55 E	1:00 a.m.1");
index= City->addkeyval("Sofia", "Bulgaria	42	40 N	23	20 E	7:00 p.m.");
index= City->addkeyval("Stockholm", "Sweden	59	17 N	18	3 E	6:00 p.m.");
index= City->addkeyval("Sydney", "Australia	34	0 S	151	0 E	3:00 a.m.1");
index= City->addkeyval("Tananarive", "Madagascar	18	50 S	47	33 E	8:00 p.m.");
index= City->addkeyval("Teheran", "Iran	35	45 N	51	45 E	8:30 p.m.");
index= City->addkeyval("Tokyo", "Japan	35	40 N	139	45 E	2:00 a.m.1");
index= City->addkeyval("Tripoli", "Libya	32	57 N	13	12 E	7:00 p.m.");
index= City->addkeyval("Venice", "Italy	45	26 N	12	20 E	6:00 p.m.");
index= City->addkeyval("Veracruz", "Mexico	19	10 N	96	10 W	11:00 a.m.");
index= City->addkeyval("Vienna", "Austria	48	14 N	16	20 E	6:00 p.m.");
index= City->addkeyval("Vladivostok", "Russia	43	10 N	132	0 E	3:00 a.m.1");
index= City->addkeyval("Warsaw", "Poland	52	14 N	21	0 E	6:00 p.m.");
index= City->addkeyval("Wellington", "New Zealand	41	17 S	174	47 E	5:00 a.m.1");
index= City->addkeyval("Zürich", "Switzerland	47	21 N	8	31 E	6:00 p.m.");
//====================USA/Can ===================//

index= City->addkeyval("Albany", "N.Y.	42	40	73	45	12:00 noon");
index= City->addkeyval("Albuquerque", "N.M.	35	05	106	39	10:00 a.m.");
index= City->addkeyval("Amarillo", "Tex.	35	11	101	50	11:00 a.m.");
index= City->addkeyval("Anchorage", "Alaska	61	13	149	54	8:00 a.m.");
index= City->addkeyval("Atlanta", "Ga.	33	45	84	23	12:00 noon");
index= City->addkeyval("Austin", "Tex.	30	16	97	44	11:00 a.m.");
index= City->addkeyval("Baker", "Ore.	44	47	117	50	9:00 a.m.");
index= City->addkeyval("Baltimore", "Md.	39	18	76	38	12:00 noon");
index= City->addkeyval("Bangor", "Maine	44	48	68	47	12:00 noon");
index= City->addkeyval("Birmingham", "Ala.	33	30	86	50	11:00 a.m.");
index= City->addkeyval("Bismarck", "N.D.	46	48	100	47	11:00 a.m.");
index= City->addkeyval("Boise", "Idaho	43	36	116	13	10:00 a.m.");
index= City->addkeyval("Boston", "Mass.	42	21	71	5	12:00 noon");
index= City->addkeyval("Buffalo", "N.Y.	42	55	78	50	12:00 noon");
index= City->addkeyval("Calgary", "Alba., Can.	51	1	114	1	10:00 a.m.");
index= City->addkeyval("Carlsbad", "N.M.	32	26	104	15	10:00 a.m.");
index= City->addkeyval("Charleston", "S.C.	32	47	79	56	12:00 noon");
index= City->addkeyval("Charleston", "W. Va.	38	21	81	38	12:00 noon");
index= City->addkeyval("Charlotte", "N.C.	35	14	80	50	12:00 noon");
index= City->addkeyval("Cheyenne", "Wyo.	41	9	104	52	10:00 a.m.");
index= City->addkeyval("Chicago", "Ill.	41	50	87	37	11:00 a.m.");
index= City->addkeyval("Cincinnati", "Ohio	39	8	84	30	12:00 noon");
index= City->addkeyval("Cleveland", "Ohio	41	28	81	37	12:00 noon");
index= City->addkeyval("Columbia", "S.C.	34	0	81	2	12:00 noon");
index= City->addkeyval("Columbus", "Ohio	40	0	83	1	12:00 noon");
index= City->addkeyval("Dallas", "Tex.	32	46	96	46	11:00 a.m.");
index= City->addkeyval("Denver", "Colo.	39	45	105	0	10:00 a.m.");
index= City->addkeyval("Des Moines", "Iowa	41	35	93	37	11:00 a.m.");
index= City->addkeyval("Detroit", "Mich.	42	20	83	3	12:00 noon");
index= City->addkeyval("Dubuque", "Iowa	42	31	90	40	11:00 a.m.");
index= City->addkeyval("Duluth", "Minn.	46	49	92	5	11:00 a.m.");
index= City->addkeyval("Eastport", "Maine	44	54	67	0	12:00 noon");
index= City->addkeyval("Edmonton", "Alb., Can.	53	34	113	28	10:00 a.m.");
index= City->addkeyval("El Centro", "Calif.	32	38	115	33	9:00 a.m.");
index= City->addkeyval("El Paso", "Tex.	31	46	106	29	10:00 a.m.");
index= City->addkeyval("Eugene", "Ore.	44	3	123	5	9:00 a.m.");
index= City->addkeyval("Fargo", "N.D.	46	52	96	48	11:00 a.m.");
index= City->addkeyval("Flagstaff", "Ariz.	35	13	111	41	10:00 a.m.");
index= City->addkeyval("Fort Worth", "Tex.	32	43	97	19	11:00 a.m.");
index= City->addkeyval("Fresno", "Calif.	36	44	119	48	9:00 a.m.");
index= City->addkeyval("Grand Junction", "Colo.	39	5	108	33	10:00 a.m.");
index= City->addkeyval("Grand Rapids", "Mich.	42	58	85	40	12:00 noon");
index= City->addkeyval("Havre", "Mont.	48	33	109	43	10:00 a.m.");
index= City->addkeyval("Helena", "Mont.	46	35	112	2	10:00 a.m.");
index= City->addkeyval("Honolulu", "Hawaii	21	18	157	50	7:00 a.m.");
index= City->addkeyval("Hot Springs", "Ark.	34	31	93	3	11:00 a.m.");
index= City->addkeyval("Houston", "Tex.	29	45	95	21	11:00 a.m.");
index= City->addkeyval("Idaho Falls", "Idaho	43	30	112	1	10:00 a.m.");
index= City->addkeyval("Indianapolis", "Ind.	39	46	86	10	12:00 noon");
index= City->addkeyval("Jackson", "Miss.	32	20	90	12	11:00 a.m.");
index= City->addkeyval("Jacksonville", "Fla.	30	22	81	40	12:00 noon");
index= City->addkeyval("Juneau", "Alaska	58	18	134	24	8:00 a.m.");
index= City->addkeyval("Kansas City", "Mo.	39	6	94	35	11:00 a.m.");
index= City->addkeyval("Key West", "Fla.	24	33	81	48	12:00 noon");
index= City->addkeyval("Kingston", "Ont., Can.	44	15	76	30	12:00 noon");
index= City->addkeyval("Klamath Falls", "Ore.	42	10	121	44	9:00 a.m.");
index= City->addkeyval("Knoxville", "Tenn.	35	57	83	56	12:00 noon");
index= City->addkeyval("Las Vegas", "Nev.	36	10	115	12	9:00 a.m.");
index= City->addkeyval("Lewiston", "Idaho	46	24	117	2	9:00 a.m.");
index= City->addkeyval("Lincoln", "Neb.	40	50	96	40	11:00 a.m.");
index= City->addkeyval("London", "Ont., Can.	43	2	81	34	12:00 noon");
index= City->addkeyval("Long Beach", "Calif.	33	46	118	11	9:00 a.m.");
index= City->addkeyval("Los Angeles", "Calif.	34	3	118	15	9:00 a.m.");
index= City->addkeyval("Louisville", "Ky.	38	15	85	46	12:00 noon");
index= City->addkeyval("Manchester", "N.H.	43	0	71	30	12:00 noon");
index= City->addkeyval("Memphis", "Tenn.	35	9	90	3	11:00 a.m.");
index= City->addkeyval("Miami", "Fla.	25	46	80	12	12:00 noon");
index= City->addkeyval("Milwaukee", "Wis.	43	2	87	55	11:00 a.m.");
index= City->addkeyval("Minneapolis", "Minn.	44	59	93	14	11:00 a.m.");
index= City->addkeyval("Mobile", "Ala.	30	42	88	3	11:00 a.m.");
index= City->addkeyval("Montgomery", "Ala.	32	21	86	18	11:00 a.m.");
index= City->addkeyval("Montpelier", "Vt.	44	15	72	32	12:00 noon");
index= City->addkeyval("Montreal", "Que., Can.	45	30	73	35	12:00 noon");
index= City->addkeyval("Moose Jaw", "Sask., Can.	50	37	105	31	11:00 a.m.");
index= City->addkeyval("Nashville", "Tenn.	36	10	86	47	11:00 a.m.");
index= City->addkeyval("Nelson", "B.C., Can.	49	30	117	17	9:00 a.m.");
index= City->addkeyval("Newark", "N.J.	40	44	74	10	12:00 noon");
index= City->addkeyval("New Haven", "Conn.	41	19	72	55	12:00 noon");
index= City->addkeyval("New Orleans", "La.	29	57	90	4	11:00 a.m.");
index= City->addkeyval("New York", "N.Y.	40	47	73	58	12:00 noon");
index= City->addkeyval("Nome", "Alaska	64	25	165	30	8:00 a.m.");
index= City->addkeyval("Oakland", "Calif.	37	48	122	16	9:00 a.m.");
index= City->addkeyval("Oklahoma City", "Okla.	35	26	97	28	11:00 a.m.");
index= City->addkeyval("Omaha", "Neb.	41	15	95	56	11:00 a.m.");
index= City->addkeyval("Ottawa", "Ont., Can.	45	24	75	43	12:00 noon");
index= City->addkeyval("Philadelphia", "Pa.	39	57	75	10	12:00 noon");
index= City->addkeyval("Phoenix", "Ariz.	33	29	112	4	10:00 a.m.");
index= City->addkeyval("Pierre", "S.D.	44	22	100	21	11:00 a.m.");
index= City->addkeyval("Pittsburgh", "Pa.	40	27	79	57	12:00 noon");
index= City->addkeyval("Portland", "Maine	43	40	70	15	12:00 noon");
index= City->addkeyval("Portland", "Ore.	45	31	122	41	9:00 a.m.");
index= City->addkeyval("Providence", "R.I.	41	50	71	24	12:00 noon");
index= City->addkeyval("Quebec", "Que., Can.	46	49	71	11	12:00 noon");
index= City->addkeyval("Raleigh", "N.C.	35	46	78	39	12:00 noon");
index= City->addkeyval("Reno", "Nev.	39	30	119	49	9:00 a.m.");
index= City->addkeyval("Richfield", "Utah	38	46	112	5	10:00 a.m.");
index= City->addkeyval("Richmond", "Va.	37	33	77	29	12:00 noon");
index= City->addkeyval("Roanoke", "Va.	37	17	79	57	12:00 noon");
index= City->addkeyval("Sacramento", "Calif.	38	35	121	30	9:00 a.m.");
index= City->addkeyval("St. John", "N.B., Can.	45	18	66	10	1:00 p.m.");
index= City->addkeyval("St. Louis", "Mo.	38	35	90	12	11:00 a.m.");
index= City->addkeyval("Salt Lake City", "Utah	40	46	111	54	10:00 a.m.");
index= City->addkeyval("San Antonio", "Tex.	29	23	98	33	11:00 a.m.");
index= City->addkeyval("San Diego", "Calif.	32	42	117	10	9:00 a.m.");
index= City->addkeyval("San Francisco", "Calif.	37	47	122	26	9:00 a.m.");
index= City->addkeyval("San Jose", "Calif.	37	20	121	53	9:00 a.m.");
index= City->addkeyval("San Juan", "P.R.	18	30	66	10	1:00 p.m.");
index= City->addkeyval("Santa Fe", "N.M.	35	41	105	57	10:00 a.m.");
index= City->addkeyval("Savannah", "Ga.	32	5	81	5	12:00 noon");
index= City->addkeyval("Seattle", "Wash.	47	37	122	20	9:00 a.m.");
index= City->addkeyval("Shreveport", "La.	32	28	93	42	11:00 a.m.");
index= City->addkeyval("Sioux Falls", "S.D.	43	33	96	44	11:00 a.m.");
index= City->addkeyval("Sitka", "Alaska	57	10	135	15	8:00 a.m.");
index= City->addkeyval("Spokane", "Wash.	47	40	117	26	9:00 a.m.");
index= City->addkeyval("Springfield", "Ill.	39	48	89	38	11:00 a.m.");
index= City->addkeyval("Springfield", "Mass.	42	6	72	34	12:00 noon");
index= City->addkeyval("Springfield", "Mo.	37	13	93	17	11:00 a.m.");
index= City->addkeyval("Syracuse", "N.Y.	43	2	76	8	12:00 noon");
index= City->addkeyval("Tampa", "Fla.	27	57	82	27	12:00 noon");
index= City->addkeyval("Toledo", "Ohio	41	39	83	33	12:00 noon");
index= City->addkeyval("Toronto", "Ont., Can.	43	40	79	24	12:00 noon");
index= City->addkeyval("Tulsa", "Okla.	36	09	95	59	11:00 a.m.");
index= City->addkeyval("Vancouver", "B.C., Can.	49	13	123	06	9:00 a.m.");
index= City->addkeyval("Victoria", "B.C., Can.	48	25	123	21	9:00 a.m.");
index= City->addkeyval("Virginia Beach", "Va.	36	51	75	58	12:00 noon");
index= City->addkeyval("Washington", "D.C.	38	53	77	02	12:00 noon");
index= City->addkeyval("Wichita", "Kan.	37	43	97	17	11:00 a.m.");
index= City->addkeyval("Wilmington", "N.C.	34	14	77	57	12:00 noon");
index= City->addkeyval("Winnipeg", "Man., Can.	49	54	97	7	11:00 a.m.");

<<"%V $index\n"

//========================================

float C2C (str cityto , str cityfr)
{

//Str vs;
//svar lval;
//svar wval;
//svar wval2;
//   TBF - crash unless declared here
double miles;




//<<"$_proc   $cityto $cityfr \n"

//cityto->info(1);

svar lval = City->lookup(cityto);

//lval->info(1);
//<<"<|$cityfr|>  ==> \n"

//vs= val[0]
//<<"$vs \n"
//vs->info(1)
svar wval = split(lval[0])
sz=Caz(wval)

//<<"%V $sz   $wval\n"
//wval->info(1)

lat =  atof(wval[1])
//lat->info(1)

//<<"$wval[1] $wval[2] $lat\n"
/*
   la1 =  atof(wval[1]) ;
   la2 =  atof(wval[2]) ;   
   la3 =  atof(wval[3]) ;
   la4 =  atof(wval[4]) ;
<<"%V $la1 $la2 $la3 $la4 \n"   
*/


  if (sz == 7) {
   latA = atof(wval[1]) + 0.01* atof(wval[2]);
   //latA = la1 + 0.01 * la2;
   lngA = atof(wval[3]) + 0.01* atof(wval[4]);
   //lngA = la3 + 0.01 * la4;

  }
  else {
  
   latA = atof(wval[1]) + 0.01* atof(wval[2]);
   //latA = la1 + 0.01* la2;

   cd = wval[3];
   if (cd @= "S") {
       latA *= -1;
   }
   
   lngA = atof(wval[4]) + 0.01* atof(wval[5]);
   //lngA = la4 + 0.01* la5;

   cd = wval[6];
   if (cd @= "E") {
       lngA *= -1;
   }


  }
//<<"%V $latA  $lngA \n"
//ans= query("c1");

//cityfr->info(1)

lval = City->lookup(cityfr)

//lval->info(1)


wval = split(lval[0])

//wval2->info(1)

sz=Caz(wval)

//<<"$sz   $wval\n"
/*
   la1 =  atof(wval2[1]) ;
   la2 =  atof(wval2[2]) ;   
   la3 =  atof(wval2[3]) ;
   la4 =  atof(wval2[4]) ;
*/


 if (sz == 7) {
   latB = atof(wval[1]) + 0.01* atof(wval[2]);
   lngB = atof(wval[3]) + 0.01* atof(wval[4]);
 //   latB = la1 + la2;
   // lngB = la3 + 0.01* la4;
  }
 else  {
   latB= atof(wval[1]) + 0.01* atof(wval[2]);
   cd = wval[3];
   if (cd @= "S") {
       latB *= -1;
   }
   lngB = atof(wval[4]) + 0.01* atof(wval[5]);
   cd = wval[6];
   if (cd @= "E") {
       lngB *= -1;
   }
 }


  km = HowFar(latA,lngA,latB,lngB);

<<"$km * $_km2mile\n"
// TBF 
// double miles = km * _km2mile;

   miles = km * _km2mile;

// double smiles = km * _km2mile;


 miles->info(1)



<<" $cityfr ==> $cityto $km km  miles $miles \n"  


//cityfr->info(1)
//<<"<|$cityfr|>   \n"



  return km;
}
//================================




key = "Aberdeen";
val = City->lookup(key)

<<"$key  $val\n"


key = "London";
val = City->lookup(key)

<<"$key  $val\n"

key = "Paris";
val = City->lookup(key)

<<"$key  $val\n"





  latA = 36 +  7.2/60.0
  lngA = (86 +  40.2/60.0)


  latB = 33 + 56.4/60.0
  lngB = (118 + 24/60.0)



key = "London";
key2 = "Sydney";

key->info(1)


//<<"$key ===> $key2 \n"

km= C2C (key , key2)



str cityA ="London"
str cityB = "Tokyo"

km= C2C (cityA , cityB)


miles = km * _km2mile



cityA ="London"
cityB = "Edinburgh"

//<<"$cityA ===> $cityB \n"
km= C2C (cityA , cityB)
 smiles = km * _km2mile
//<<"$cityA to $cityB is $km  $smiles ??\n"




////   str const as var
cityA="Denver"
cityB = "Madrid"
//<<"$cityA ===> $cityB \n"

//km= C2C ("Denver" , "Madrid")
//km= C2C (cityA , cityB)

km= C2C (cityA , cityB)


cityA ="Berlin"
cityB = "Paris"
//<<"$cityA ===> $cityB \n"

km= C2C (cityA , cityB)
 smiles = km * _km2mile
//<<"$cityA to $cityB is $km  $smiles ??\n"







cityB ="Denver"
cityA = "Rome"

//<<"$cityA ===> $cityB \n"

km= C2C (cityA , cityB)
 smiles = km * _km2mile
//<<"$cityA ==> $cityB is $km  $smiles ??\n"




km= C2C ("Rome" , "New York")
miles = km * _km2mile












if (do_query) {


city1 = query("from ?")
city2 = query("to ?")

km= C2C (city1 , city2)

 miles = km * _km2mile
 
<<"$city1 to $city2 is $km  $miles ??\n"
}





/////////////////////////////////////////


/*
  km = HowFar(latA,lngA,latB,lngB,2)


<<"%V$latA $lngA $latB $lngB  $km  $miles\n" 

  km = HowFar(latA,lngA,latB,lngB,3)


<<"%V$latA $lngA $latB $lngB  $km\n" 

  

  dlon = deg2rad((lngA - lngB))
  dlat = deg2rad((latA - latB))
  latA = deg2rad(latA)
  latB = deg2rad(latB)



  a = (cos(latB) * sin (dlon))

  b =  (cos(latA) * sin (latB)) - (sin(latA) * cos (latB) * cos(dlon))

  c = sqrt( a*a + b*b)

  d= sin(latA) * sin(latB) + cos(latA) * cos(latB) * cos (dlon)

  ang  = atan2(c,d)


  ang2 = atan2(sqrt( sqr(cos(latB) * sin (dlon))  + sqr((cos(latA) * sin (latB)) - (sin(latA) * cos (latB) * cos(dlon)))), \
                (sin(latA) * sin(latB) + cos(latA) * cos(latB) * cos (dlon)))




//  ang  = atan(c/d)

<<"%V$a $b $c $d $ang $ang2\n"

  D = 6371 * ang2

<<"%V$D \n"
*/
