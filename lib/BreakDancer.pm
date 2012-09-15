module BreakDancer;
use Shell::Command;

my $basedir = 'www';

multi gen($path, &code) is export {
    mkpath "$basedir/$path";
    given open("$basedir/$path/index.htm", :w) {
        .say: &code();
        .close;
    }
}

multi gen($path is copy, %args, &code) is export {
    mkpath "$basedir/$path";
    for %args.kv -> $k, $v {
        my $p = "$basedir/$path/$k";
        mkpath $p;
        given open("$p/index.htm", :w) {
            .say: &code($k, $v);
            .close;
        }
    }
}
