#!/usr/bin/perl
push (@INC, `pwd`);

use strict;
use warnings;
use B qw/svref_2object/;
use PerlakeTasks;

my $task = shift;
my $perlakeTasks = new PerlakeTasks;
if ($task =~ /-T/) {
	my $perlakeTasks = new PerlakeTasks;
	my @tasks = list_module("PerlakeTasks");
	@tasks = grep(!/new/, @tasks);
	@tasks = grep(!/^desc_/, @tasks);
	for $task (@tasks) {
		my $descMethod = "desc_$task";
		my $desc = $perlakeTasks->$descMethod();
		print __FILE__ . " $task\t # $desc\n";
	}
} else {
	my $taskMethod = "$task";
	$perlakeTasks->$taskMethod();
}

sub list_module {
    my $module = shift;
    no strict 'refs';
    return grep { defined &{"$module\::$_"} } keys %{"$module\::"}
}

