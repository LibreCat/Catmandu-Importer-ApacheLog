# NAME

Catmandu::Importer::ApacheLog - Catmandu importer for importing log entries

# STATUS

[![Build Status](https://travis-ci.org/LibreCat/Catmandu-Importer-ApacheLog.svg?branch=master)](https://travis-ci.org/LibreCat/Catmandu-Importer-ApacheLog)
[![Coverage](https://coveralls.io/repos/LibreCat/Catmandu-Importer-ApacheLog/badge.png?branch=master)](https://coveralls.io/r/LibreCat/Catmandu-Importer-ApacheLog)
[![CPANTS kwalitee](http://cpants.cpanauthors.org/dist/Catmandu-Importer-ApacheLog.png)](http://cpants.cpanauthors.org/dist/Catmandu-Importer-ApacheLog)

# SYNOPSIS

    #!/usr/bin/env perl
    use Catmandu::Importer::ApacheLog;
    use Data::Dumper;

    my $importer = Catmandu::Importer::ApacheLog->new(
        file => "/var/log/httpd/access_log"
    );

    $importer->each(sub{
        print Dumper(shift);
    });

    #!/bin/bash
    catmandu convert ApacheLog --file access.log to YAML

# DESCRIPTION

This importer reads every entry in the log file, and put the log entries (status, rhost ..) into a record.
The original line is stored in the attribute '\_log'.

# METHODS

## new ( file => $file, fix => $fix, formats => \['combined','common'\] )

- file

        File to import. Can also be a string reference or a file handle. See L<Catmandu::Importer>

- fix

        Fix to apply to every record. See L<Catmandu::Importer>

- formats

        Array reference of formats

        By default ['combined','common']

        For more information see L<Apache::Log::Parser>, and look for the option 'fast'.


# AUTHORS

    Nicolas Franck C<< <nicolas.franck at ugent.be> >>

# SEE ALSO

    L<Catmandu>, L<Catmandu::Importer> , L<Apache::Log::Parser>
