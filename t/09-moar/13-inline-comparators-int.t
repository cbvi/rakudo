use Test;
use MoarVM::SIL;

%*ENV<MVM_SPESH_BLOCKING> = 1;

# running the tests after the code has run
if SIL() -> $SIL {
    my @names =
      'infix:<==>', 'infix:<!=>', 'infix:«>»', 'infix:«>=»',
      'infix:«<»',  'infix:«<=»', 'infix:«<=>»',
    ;

    plan +@names;

    for @names {
        ok $SIL.inlined-by-name($_), "Was $_ inlined?";
    }
}

# running the code
else {
    my $a = 42;
    my $b = 666;
    for ^1000 {
        my $c;
        $c := $a == $b;
        $c := $a != $b;
        $c := $a > $b;
        $c := $a >= $b;
        $c := $a < $b;
        $c := $a <= $b;
        $c := $a <=> $b;
    }
}

# vim: expandtab shiftwidth=4
