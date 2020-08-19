// test transcendental funcs



y = Sin(0)

<<"$y \n"

y = Cos(0)

<<"$y \n"

y = Tan(0)

<<"$y \n"

msg=whatis("Cos")
<<"$msg \n"

msg=whatis("sinh")
<<"$msg \n"

msg=whatis("exp")
<<"$msg \n"

y = Exp(1.0)
<<"$y $(whatis(Exp))\n"