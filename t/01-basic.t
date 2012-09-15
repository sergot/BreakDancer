use v6;
use BreakDancer;
use Test;
use Shell::Command;

my %modules =
    foo => [1, 'asd'],
    bar => [2, 'fasada']
;

# argumentless form?
gen '/', sub {
    return "lalala"
}

gen '/module', %modules, sub ($mod, $args) {
    return "$mod: " ~ $args[1] x $args[0];
}

my $basedir = 'www'; # or maybe 'gen'?

ok "$basedir/index.htm".IO.f;
is slurp("$basedir/index.htm").chomp, 'lalala';

for %modules.kv -> $k, $v {
    ok "$basedir/module/$k/index.htm".IO.f;
    is slurp("$basedir/module/$k/index.htm").chomp,
       ("$k: " ~ $v[1] x $v[0]);
}

rm_rf $basedir; # cleanup

done;
