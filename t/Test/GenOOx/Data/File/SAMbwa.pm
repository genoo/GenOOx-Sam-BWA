package Test::GenOOx::Data::File::SAM;

use base qw(Test::GenOOx);
use Test::Moose;
use Test::Most;


sub class {
	my ($self) = @_;
	
	return 'GenOO::Data::File::SAM';
}

#######################################################################
################   Startup (Runs once in the begining  ################
#######################################################################
sub _check_loading : Test(startup => 1) {
	my ($self) = @_;
	use_ok $self->class;
};

#######################################################################
#################   Setup (Runs before every method)  #################
#######################################################################
sub create_new_test_objects : Test(setup) {
	my ($self) = @_;
	
	my $test_class = ref($self) || $self;
	$self->{TEST_OBJECTS} = $test_class->test_objects();
};

#######################################################################
##########################   Initial Tests   ##########################
#######################################################################
sub _isa_test : Test(1) {
	my ($self) = @_;
	
	isa_ok $self->obj(0), $self->class, "... and the object";
}

#######################################################################
##########################   Interface Tests   ########################
#######################################################################
sub records_read_count : Test(5) {
	my ($self) = @_;
	
	can_ok $self->obj(0), 'records_read_count';
	is $self->obj(0)->records_read_count, 0, "... and should return the correct value";
	
	$self->obj(0)->next_record();
	is $self->obj(0)->records_read_count, 1, "... and should return the correct value again";
	
	$self->obj(0)->next_record();
	is $self->obj(0)->records_read_count, 2, "... and again";
	
	while ($self->obj(0)->next_record()) {}
	is $self->obj(0)->records_read_count, 978, "... and again (when the whole file is read)";
}

sub next_record : Test(2) {
	my ($self) = @_;
	
	can_ok $self->obj(0), 'next_record';
	isa_ok $self->obj(0)->next_record, 'GenOO::Data::File::SAM::Record', "... and the returned object";
}

#######################################################################
###########################   Private Tests   #########################
#######################################################################
sub parse_record_line : Test(22) {
	my ($self) = @_;
	
	can_ok $self->obj(0), '_parse_record_line';
	
	my $sample_line = join("\t",('HWI-EAS235_25:1:1:4282:1093', '16', 'chr18', '85867636', '0', '32M', '*', '0', '0', 'ATTCGGCAGGTGAGTTGTTACACACTCCTTAG', 'GHHGHHHGHHGGGDGEGHHHFHGG<GG>?BGG', 'XT:A:R', 'NM:i:0', 'X0:i:2', 'X1:i:0', 'XM:i:0', 'XO:i:0', 'XG:i:0', 'MD:Z:32', 'XA:Z:chr9,+110183777,32M,0;'));
	
	my $record = $self->obj(0)->_parse_record_line($sample_line);
	isa_ok $record, 'GenOOx::Data::File::SAMbwa::Record', '... and object returned';
	is $record->qname, 'HWI-EAS235_25:1:1:4282:1093', '... and should contain correct value';
	is $record->flag, '16', '... and should contain correct value again';
	is $record->rname, 'chr18', '... and again';
	is $record->pos, 85867636, '... and again';
	is $record->mapq, '0', '... and again';
	is $record->cigar, '32M', '... and again';
	is $record->rnext, '*', '... and again';
	is $record->pnext, 0, '... and again';
	is $record->tlen, 0, '... and again';
	is $record->seq, 'ATTCGGCAGGTGAGTTGTTACACACTCCTTAG', '... and again';
	is $record->qual, 'GHHGHHHGHHGGGDGEGHHHFHGG<GG>?BGG', '... and again';
	is $record->tag('XT:A'), 'R', '... and again';
	is $record->tag('NM:i'), '0', '... and again';
	is $record->tag('X0:i'), '2', '... and again';
	is $record->tag('X1:i'), '0', '... and again';
	is $record->tag('XM:i'), '0', '... and again';
	is $record->tag('XO:i'), '0', '... and again';
	is $record->tag('XG:i'), '0', '... and again';
	is $record->tag('MD:Z'), '32', '... and again';
	is $record->tag('XA:Z'), 'chr9,+110183777,32M,0;', '... and again';
}


#######################################################################
###############   Class method to create test objects   ###############
#######################################################################
sub test_objects {
	my ($test_class) = @_;
	
	eval "require ".$test_class->class;
	
	my @test_objects;
	push @test_objects, $test_class->class->new(
		file          => 't/sample_data/sample.sam.gz',
		records_class => 'GenOOx::Data::File::SAMbwa::Record'
	);
	
	return \@test_objects;
}

1;
