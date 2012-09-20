package PerlakeTaskSet;

require utf8;
require Exporter;

# Notice, use 'require' to additional package instead of 'use'.
require File::Basename;

@ISA = qw (Exporter);
@EXPORT = qw ();

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	$self->_init();
	return $self;
}

# Specify your own initialize logic here.
sub _init {
}

# Here's some examples about task and its description.
sub desc_build {
	"build task description";
}

sub build {
	print "Building...";
}

sub desc_test {
	"test task description";
}

sub test {
	my $this = shift;
	my @args = @_;
	print "Testing @args";
}

1;
