///
///  veccat
///
setdebug(1);

int vec1[]  = { 1,2,3};

<<"%v$vec1 \n"

int vec2[] = {7,8,9}

<<"%V $vec2\n"

int vec3 []  = vec1 @+  vec2;

<<"%V $vec3 \n"
<<"$vec3[1] $vec3[2] $vec3[4] \n"

vec4 = vec1 @+  vec2;

<<"%V $vec4 \n"
