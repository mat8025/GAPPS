///
/// bump.asl
///

y= _clarg[1]

!!"asl bvers.asl "
done=!!"make install"
<<"%V $done \n"
sleep(2)
v= get_version() ; // gets old version!
//

v2=!!"asl -v" ; // this gets new
<<"$v2\n"
vn = split(v2)
z="\'$vn[0] $y\'"
<<"asl evers.asl $z \n"
!!"asl evers.asl $z"