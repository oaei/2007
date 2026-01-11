# strip non-ASCII characters from each file listed on the command line
# USAGE: strip.pl file.txt file.doc file.xls file.zip file.gif ...
#
use strict;
use warnings;

my $i;
my $file;
my $fout;
my $fhin;
my $fhout;

for ($i=0; $ARGV[$i]; $i++) {
    $file = $ARGV[$i];
    $fout = "$file.stripped";
    print "stripping > " . $file . "< to >" . $fout . "<\n";
    open ($fhin,  "<$file") or die "Trouble opening $file: $!\n";
    open ($fhout, "> $fout") or die "Trouble opening $fout: $!\n";
    binmode ($fhin);
    binmode ($fhout);
    while (<$fhin> ) {
        # space, tab, newline, return, alphanumeric, punctuation
    	s/[^ \t\n\r\w~!@#$%^&*()_+`\-=[\]\\{}|;':",.\/<> ?]*//g;
    	print $fhout $_;
    }
    close($fhin)  or die "Trouble closing $file: $!\n";
    close($fhout) or die "Trouble closing $fout: $!\n";
}
