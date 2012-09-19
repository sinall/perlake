#!/usr/bin/perl
push (@INC, `pwd`);

use strict;
use warnings;
use B qw/svref_2object/;
use PerlakeTasks;

my $task = shift;
if ($task =~ /-T/) {
	print "Listing all tasks here:\n";
	my @tasks = list_module("PerlakeTasks");
	print join("\n", @tasks), "\n";
} else {
	my $func = "task_run_$task";
	main->$func();
}

sub in_package {
    my ($coderef, $package) = @_;
    my $cv = svref_2object($coderef);
    return if not $cv->isa('B::CV') or $cv->GV->isa('B::SPECIAL');
    return $cv->GV->STASH->NAME eq $package;
}

sub list_module {
    my $module = shift;
    no strict 'refs';

    return grep { defined &{"$module\::$_"} and in_package(\&{*$_}, $module) } keys %{"$module\::"}
}

