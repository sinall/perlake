﻿package PerlakeTaskSet;

require Exporter;
@ISA = qw (Exporter);
@EXPORT = qw ();

sub new {
  my $this = {};
  bless $this;
  $this->_init();
  return $this;
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
	print "Testing...";
}

1;