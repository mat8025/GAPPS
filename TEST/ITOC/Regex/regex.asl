

checkIn()


str C = "mat.vox"

str D = "terry.pcm"

str E = "terry.vox"

str F = "terry.phn"


p = regex(C,"vox")

<<"$p \n"

checkNum(p[0],4)

p = regex(D,"pcm")

checkNum(p[0],6)

//p = regex(D,'pcm\|vox')
p = regex(D,'pcm|vox|phn')
<<"$p \n"
checkNum(p[0],6)

p = regex(E,'pcm|vox|phn')
<<"$p \n"
checkNum(p[0],6)

p = regex(F,'pcm|vox|phn')
<<"$p \n"
checkNum(p[0],6)





svar S;
S[0] = "DBPR   (";
S[1] = "DBPR  				(";
S[2] = "DBPR(";
S[3] = "DBPR[";



for ( i =0; i< 3; i++) {
p = regex(S[i],'DBPR ?+')

<<"$p\n"
checkNum(p[0],0)
}

p = regex(S[3],"DBPR *\t*\\(")

<<"$p\n"
checkNum(p[0],-1)

<<"DQ  & conline\n"
T= "Highlighting regular expression matches in EditPad Pro. As a quick test, copy and paste the text of this page into EditPad Pro. Then select Search|Multiline Search Panel in the menu. \
In the search panel that appears near the bottom, type in regex in the box labeled \"Search Text\".\
 Mark the \"Regular expression\" checkbox, and click the Find First button. This is the leftmost button on the search panel. \
See how EditPad Pro's regex engine finds the first match. \
Click the Find Next button, which sits next to the Find First button, to find further matches. \
When there are no further matches, the Find Next button's icon flashes briefly.";


<<"$T\n"
<<"//////////////////////\n"
<<"DQ  single line\n"
T= "Highlighting regular expression matches in EditPad Pro. As a quick test, copy and paste the text of this page into EditPad Pro. Then select Search|Multiline Search Panel in the menu. In the search panel that appears near the bottom, type in regex in the box labeled \"Search Text\". Mark the \"Regular expression\" checkbox, and click the Find First button. This is the leftmost button on the search panel. See how EditPad Pro's regex engine finds the first match. Click the Find Next button, which sits next to the Find First button, to find further matches. When there are no further matches, the Find Next button's icon flashes briefly.";
<<"$T\n"



<<"//////////////////////\n"
<<"SQ\n"
R= 'Highlighting regular expression matches in EditPad Pro. As a quick test, copy and paste the text of this page into EditPad Pro. Then select Search|Multiline Search Panel in the menu. In the search panel that appears near the bottom, type in regex in the box labeled "Search Text". Mark the "Regular expression" checkbox, and click the Find First button. This is the leftmost button on the search panel. See how EditPad Pro\'s regex engine finds the first match. Click the Find Next button, which sits next to the Find First button, to find further matches. When there are no further matches, the Find Next button\'s icon flashes briefly.';

<<"$R\n"








W= "\
/{
Highlighting regular expression matches in EditPad Pro. As a quick test, copy and paste the text of this page into EditPad Pro. Then select Search|Multiline Search Panel in the menu. 
In the search panel that appears near the bottom, type in regex in the box labeled "Search Text".
 Mark the "Regular expression" checkbox, and click the Find First button. This is the leftmost button on the search panel. 
See how EditPad Pro's regex engine finds the first match. 
Click the Find Next button, which sits next to the Find First button, to find further matches. 
When there are no further matches, the Find Next button's icon flashes briefly.
/} \
";
checkOut(); exit();




/{
In the search panel that appears near the bottom, type in regex in the box labeled "Search Text". Mark the "Regular expression" checkbox, and click the Find First button. This is the leftmost button on the search panel. See how EditPad Pro's regex engine finds the first match. Click the Find Next button, which sits next to the Find First button, to find further matches. When there are no further matches, the Find Next button's icon flashes briefly.";


Now try to search using the regex reg(ular expressions?|ex(p|es)?). This regex finds all names, singular and plural, I have used on this page to say "regex". If we only had plain text search, we would have needed 5 searches. With regexes, we need just one search. Regexes save you time when using a tool like EditPad Pro. Select Count Matches in the Search menu to see how many times this regular expression can match the file you have open in EditPad Pro.\

If you are a programmer, your software will run faster since even a simple regex engine applying the above regex once will outperform a state of the art plain text search algorithm searching through the data five times. Regular expressions also reduce development time. With a regex engine, it takes only one line (e.g. in Perl, PHP, Python, Ruby, Java, or .NET) or a couple of lines (e.g. in C using PCRE) of code to, say, check if the user's input looks like a valid email address. ';
/}



