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

    Code for using XMP::Parser taken from Ray & McIntosh. 2002. Perl & XML.
    O'Reilly.
    
    See publication by Stephan Nylinder et al. "On the Biogeography of Centipeda: A Species
    Tree Diffusion Approach". Syst. Biol. 2014, 63:178-191.

AUTHOR:

    Johan Nylander, nbis.se

VERSION:

    1.0

CREATED:

    10/10/2013 09:42:21 AM

REVISION:

    11/20/2013 10:00 AM

DOWNLOAD:

    https://github.com/nylander/reformatKML

LICENSE:

    Copyright (c) 2013-2020 Johan Nylander
               
    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:
    
    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.

