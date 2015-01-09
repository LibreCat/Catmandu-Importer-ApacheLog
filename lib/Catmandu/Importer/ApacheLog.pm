package Catmandu::Importer::ApacheLog;
use Catmandu::Sane;
use Catmandu::Util qw(:is :check);
use Apache::Log::Parser;
use Moo;

our $VERSION = '0.01';

with 'Catmandu::Importer';

has formats => (
    is => 'ro',
    isa => sub { check_array_ref($_[0]); },
    required => 1,
    lazy => 1,
    default => sub { ["common","combined"]; }
);
has _parser  => (
	is       => 'ro',
    init_arg => undef,
    lazy     => 1,
    builder  => '_build_parser',
);

sub _build_parser {
    my $self = $_[0];
    Apache::Log::Parser->new(fast => 1,@{ $self->formats() });
}

sub generator {
	my ($self) = @_;

	return sub {
        state $fh = $self->fh;
        state $parser = $self->_parser();
        my $line = <$fh>;
        return unless defined $line;
        my $l = $line;
        chomp $l;
        my $r =  $parser->parse($line);
        $r->{_log} = $line;
        $r;
	}
}

=head1 NAME

Catmandu::Importer::ApacheLog - Catmandu importer for importing log entries

=head1 DESCRIPTION

This importer reads every entry in the log file, and extracts the parts into a record.
The original line is stored in the attribute '_log'.

=head1 METHODS

=head2 new(file => $file,fix => $fix,formats => ['combined','common'])

=head1 SYNOPSIS

use Catmandu::Importer::ApacheLog;
use Data::Dumper;

my $importer = Catmandu::Importer::ApacheLog->new(
    file => "/var/log/httpd/access_log"
);

$importer->each(sub{
    print Dumper(shift);
});

=head1 AUTHORS

Nicolas Franck C<< <nicolas.franck at ugent.be> >>

=head1 SEE ALSO

L<Catmandu>, L<Catmandu::Importer> , L<Apache::Log::Parser>

=cut

1;
