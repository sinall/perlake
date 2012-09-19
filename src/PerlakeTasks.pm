package PerlakeTasks;

require Exporter;
@ISA = qw (Exporter);
@EXPORT = qw ();

sub new {
  my $this = {}; # Create an anonymous hash, and #self points to it.
  bless $this; # Connect the hash to the package Cocoa.
  return $this; # Return the reference to the hash.
}

sub desc_build {
	print "Running.\n";
}

sub build {
	print "Description.\n";
}

1;
