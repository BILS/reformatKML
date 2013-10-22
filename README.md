reformatKML
===========

FILE:

    reformatKML.pl

USAGE:

    ./reformatKML.pl input.kml
    ./reformatKML.pl -f=0.5 infile(s)
    ./reformatKML.pl -noverbose infile(s)
    ./reformatKML.pl -h

DESCRIPTION:

    Reformat kml files to Stephan's output format. Reads file name(s) from
    standard in, prints to new file(s) with file ending ".new.kml".

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

OPTIONS:

    -f=*nr* for specifying fill value (*nr*). Default is 0.5.

    -h,--help
            display help

    -v,--verbose
            display some output to standard error.

    -nv,--noverbose
            no output to stderr

NOTES:

    Parser and output are specific to given input format. Check output for
    consistency.

    Code fro using XMP::Parser taken from Ray & McIntosh. 2002. Perl & XML.
    O'Reilly.

AUTHOR:

    Johan Nylander, bils.se

VERSION:

    1.0

CREATED:

    10/10/2013 09:42:21 AM

REVISION:

    10/22/2013 01:11:03 PM

DOWNLOAD:

    https://github.com/nylander/reformatKML



