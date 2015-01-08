# NAME

Catmandu::Importer::ApacheLog - Catmandu importer for importing log entries

# DESCRIPTION

This importer reads every entry in the log file, and extracts the parts into a record.
The original line is stored in the attribute '\_log'.

# METHODS

## new(file => $file,fix => $fix,fast => 1,formats => \['combined','common'\])

# SYNOPSIS

use Catmandu::Importer::ApacheLog;
use Data::Dumper;

my $importer = Catmandu::Importer::ApacheLog->new(
    fast => 1,
    file => "/var/log/httpd/access\_log"
);

$importer->each(sub{
    print Dumper(shift);
});

# AUTHORS

Nicolas Franck `<nicolas.franck at ugent.be>`

# SEE ALSO

[Catmandu](https://metacpan.org/pod/Catmandu), [Catmandu::Importer](https://metacpan.org/pod/Catmandu::Importer) , [Apache::Log::Parser](https://metacpan.org/pod/Apache::Log::Parser)
