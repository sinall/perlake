#!/usr/bin/perl
push (@INC, `pwd`);

use strict;
use warnings;
use utf8;
use PerlakeTaskSet;

if (scalar(@ARGV) == 0) {
	die "Usage: " . __FILE__ . " -T|<task>\n";
}
my $task = shift;
my $perlakeTaskSet = new PerlakeTaskSet;
my @methods = list_methods("PerlakeTaskSet");
if ($task =~ /-T/) {
	help($task)
} else {
	&run_task($task, @methods)
}

sub help {
	my @tasks = grep(!/new/, @methods);
	@tasks = grep(!/^_/, @tasks);
	@tasks = grep(!/^desc_/, @tasks);
	for $task (@tasks) {
		my $descMethod = "desc_$task";
		my $desc = $perlakeTaskSet->$descMethod();
		print __FILE__ . " $task\t # $desc\n";
	}
}

sub run_task {
	my @tasks = grep(/^$task/, @methods);
	my $taskCount = scalar(@tasks);
	if ($taskCount == 0) {
		die "perlake aborted!\nDon't know how to build task '$task'\n";
	}
	my $taskMethod = "$task";
	$perlakeTaskSet->$taskMethod(@ARGV);
}

sub list_methods {
    my $package = shift;
    no strict 'refs';
    return grep { defined &{"$package\::$_"} } keys %{"$package\::"}
}
