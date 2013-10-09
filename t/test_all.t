#!/usr/bin/env perl
use Modern::Perl;

use Test::Class::Moose::Load 't/lib/';
Test::Class::Moose->new({
	show_timing => 0,
	randomize   => 0,
	statistics  => 1,
})->runtests;