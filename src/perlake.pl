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
	run_task($task, @methods)
}

sub help {
	my @tasks = grep(!/new/, @methods);
	@tasks = grep(!/^_/, @tasks);
	@tasks = grep(!/^desc_/, @tasks);
	my $maxLength = max_length(@tasks);
	for $task (@tasks) {
		my $descMethod = "desc_$task";
		my $desc = $perlakeTaskSet->$descMethod();
		printf("%s %-${maxLength}s\t# %s\n", __FILE__, $task, $desc);
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

sub max_length {
	my @tasks = @_;
	
	my $maxLength = 0;
	for $task (@tasks) {
		my $length = length($task);
		if ($maxLength < $length)
		{
			$maxLength = $length;
		}
	}
	
	$maxLength;
}

