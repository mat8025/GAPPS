

while (1) {

   S= readline(0)

//<<"$S\n"
T= split(S);

  if (feof(0) ) {
      break;
  }

<<"\tcase ${T[1]}:\n\t\treturn \"$T[1]\";\n"

}