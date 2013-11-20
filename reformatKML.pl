#!/usr/bin/perl
#===============================================================================

=pod

=head1 FILE:

reformatKML.pl

=head1 USAGE:

=over 8

=item ./reformatKML.pl input.kml

=item ./reformatKML.pl -f=0.5 infile(s)

=item ./reformatKML.pl -noverbose infile(s)

=item ./reformatKML.pl -h

=back

=head1  DESCRIPTION:

Reformat kml files to Stephan's output format (see publication reference in NOTES below).

Reads file name(s) from standard in, prints to new file(s) with file ending ".new.kml".

Example output:

    <?xml version="1.0" encoding="UTF-8"?>
    <kml>
        <Polygon id="1" fillValue="0.5">
            <coordinates>
                59.67092993700869,14.21821649950053,0
                59.3154938504766,12.94636436386756,0
                58.49650823112883,12.54670859382397,0
                57.61287555467409,12.92791857638056,0
                57.315714136905,14.40085755874797,0
                57.75939797989069,16.23159215054945,0
                58.88174459958986,16.59405807830233,0
                59.47730156931067,15.63992197616331,0
                59.67092993700869,14.21821649950053,0
            </coordinates>
        </Polygon>
    </kml>


=head1 OPTIONS:

=over 8

=item B<-f>=I<nr>

for specifying fill value (I<nr>). Default is 0.5.


=item B<-h,--help>

display help


=item B<-v,--verbose>

display some output to standard error.


=item B<-nv,--noverbose>

no output to stderr


=back


=head1 NOTES:

Parser and output are specific to given input format. Check output for consistency.

Code for using XMP::Parser taken from Ray & McIntosh. 2002. Perl & XML. O'Reilly.

See publication by Stephan Nylinder et al. "On the Biogeography of Centipeda: A Species
Tree Diffusion Approach". Syst. Biol. [Accepted manuscript]



=head1 AUTHOR:

Johan Nylander, bils.se


=head1 VERSION:

1.0


=head1 CREATED:

10/10/2013 09:42:21 AM


=head1 REVISION:

11/20/2013 10:00 AM


=head1 DOWNLOAD:

https://github.com/nylander/reformatKML


=cut

#===============================================================================

use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;
use XML::Parser;


## Globals
my $verbose       = 1;           # Change here to 0 or use --noverbose to be quiet
my $fillValue     = 0.5;         # Default set to 0.5
my $newfileending = '.new.kml';  # Default file ending for new files
my $tab1          = "\t";
my $tab2          = $tab1 x 2;
my $tab3          = $tab1 x 3;
my $fillvalue;
my $help;


## Get any options
exec( 'perldoc', $0 ) unless (@ARGV);
GetOptions(
    "f=f"      => \$fillvalue,
    "help"     => sub { exec( "perldoc", $0 ); },
    "verbose!" => \$verbose,
    );
if ($fillvalue) {
    $fillValue = $fillvalue;
}

## Look for files
while(my $infile = shift(@ARGV)) {

    my $record;
    my $context;
    my %coordinates;
    my @coords = ();

    my $name = $infile;
    $name =~ s/\.(.+)$//;
    my $outfile = $name . $newfileending;
    if ( -e $outfile ) {
        die "Error: Covardly refusing to overwrite existing file:\n\t$outfile\n";
    }
    open FH, ">", $outfile or die "Error: Could not open outfile for writing: $! \n";

    ## initialize the parser with references to handler routines
    my $parser = XML::Parser->new( Handlers => {
        Init =>    \&handle_doc_start,
        Start =>   \&handle_elem_start,
        End =>     \&handle_elem_end,
        Char =>    \&handle_char_data,
        Final =>   \&handle_doc_end,
    });
    
    ## Do the parsing
    $parser->parsefile($infile);

    ## Check for output
    if ( -e $outfile ) {
        print STDERR "$infile" if $verbose;
        print STDERR "-> $outfile\n" if ($verbose);
    }
    else {
        die "Error: Could not write outfile $outfile : $! \n";
    }


    ### Handlers
    #
    ## As processing starts, output the beginning of an KML file
    sub handle_doc_start {
        print FH "<?xml version=\"1.0\" encoding=\"UTF-8\"?>","\n"; # Note, script doesn't read encoding from input!
        print FH "<kml>\n";
        print FH $tab1, "<Polygon id=\"$name\" fillValue=\"$fillValue\">", "\n";
        print FH $tab2, '<coordinates>', "\n";
    }

    ## Save element name and attributes
    sub handle_elem_start {
        my($expat, $name, %atts) = @_;
        $context = $name;
        if($name eq 'coordinates') {
            $record = {};
        }
    } 

    ## Collect character data into the recent element's buffer
    sub handle_char_data {
        my($expat, $text) = @_;
        $text =~ s/^\s+//;
        $text =~ s/\s+$//;
        $record->{ $context } .= $text;
    }

    ## If coordinates in record, save to array 
    sub handle_elem_end {
        my($expat, $name) = @_;
        return unless( $name eq 'coordinates' );
        (@coords) = split /\s+/, $record->{'coordinates'};
    }

    ## Print at end of doc
    sub handle_doc_end {
        foreach my $co (@coords) {
            my (@a) = split /,/, $co;
            print FH $tab3, "$a[1],$a[0],$a[2]", "\n"; # reverse lat, long
        }
        print FH $tab2, '</coordinates>', "\n";
        print FH $tab1, '</Polygon>',     "\n";
        print FH '</kml>', "\n";
        close(FH);
    }
}
exit;


__DATA__
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>Test.kml</name>
	<Style id="s_ylw-pushpin_hl">
		<IconStyle>
			<scale>1.3</scale>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>
			</Icon>
			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>
		</IconStyle>
	</Style>
	<StyleMap id="m_ylw-pushpin">
		<Pair>
			<key>normal</key>
			<styleUrl>#s_ylw-pushpin</styleUrl>
		</Pair>
		<Pair>
			<key>highlight</key>
			<styleUrl>#s_ylw-pushpin_hl</styleUrl>
		</Pair>
	</StyleMap>
	<Style id="s_ylw-pushpin">
		<IconStyle>
			<scale>1.1</scale>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>
			</Icon>
			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/>
		</IconStyle>
	</Style>
	<Placemark>
		<name>Test</name>
		<styleUrl>#m_ylw-pushpin</styleUrl>
		<Polygon>
			<tessellate>1</tessellate>
			<outerBoundaryIs>
				<LinearRing>
					<coordinates>
						14.21821649950053,59.67092993700869,0 12.94636436386756,59.3154938504766,0 12.54670859382397,58.49650823112883,0 12.92791857638056,57.61287555467409,0 14.40085755874797,57.315714136905,0 16.23159215054945,57.75939797989069,0 16.59405807830233,58.88174459958986,0 15.63992197616331,59.47730156931067,0 14.21821649950053,59.67092993700869,0 
					</coordinates>
				</LinearRing>
			</outerBoundaryIs>
		</Polygon>
	</Placemark>
</Document>
</kml>
