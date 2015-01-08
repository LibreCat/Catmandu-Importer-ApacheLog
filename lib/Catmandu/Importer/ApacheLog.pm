package Catmandu::Importer::ApacheLog;
use Catmandu::Sane;
use Catmandu::Util qw(:is :check);
use Apache::Log::Parser;
use Moo;

our $VERSION = '0.01';

with 'Catmandu::Importer';

has fast    => (is => 'ro');
has strict  => (is => 'ro');
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
    my %args;
    if($self->fast){
        $args{fast} = $self->fast;
    }
    elsif($self->strict){
        check_array_ref($self->strict());
        $args{strict} = $self->strict();
    }
    Apache::Log::Parser->new(%args,@{ $self->formats() });
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

1;
