///
///
///


proc Foo(b)
{
   return (b+1);
}

//<<"$Vers  $(vers2ele(Vers))\n"

a=Foo(7);

<<"$a $(typeof(a))\n"

// BUG can't use Proc within << statement
// unlike function
//

<<"$(Foo(1))\n"

