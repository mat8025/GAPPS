setdebug(0)
!!"asl -v > vers"
!!"cat vers"
A=ofr("vers")
S=readfile(A)
C=split(S)
C->dewhite()
<<"$C\n"
vs=scat("score_",C[0],".txt")

!!"asl score_it.asl > $vs "
!!"cp $vs current_score"