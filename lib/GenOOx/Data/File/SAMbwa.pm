# POD documentation - main docs before the code

=head1 NAME

GenOOx::Data::File::SAMbwa - Module for reading SAM files generated from BWA aligner

=head1 SYNOPSIS

This module is a plugin for the GenOO framework. Include it in your script and ask GenOO SAM parser to use it.

    use GenOOx::Data::File::SAMstar::Record;

    my $file_parser = GenOO::Data::File::SAM->new(
        file          => 'file.sam',
        records_class => 'GenOOx::Data::File::SAMstar::Record'
    );

    while (my $record = $file_parser->next_record) {
        # $record is now an instance of GenOOx::Data::File::SAMstar::Record.
        print $record->cigar."\n"; # name
        print $record->flag."\n"; # flag
        print $record->number_of_mappings."\n"; # new stuff not present by default
    }


=head1 DESCRIPTION

The GenOO framework SAM parser avoids code that is unique to specific programs and makes no assumptions for the optional fields in a SAM file. This module is a plugin for the GenOO framework and provides the functionality for reading SAM files generated from the BWA aligner. The module has been created on top of the generic GenOO SAM parser and to use it just include it in your scripts and ask GenOO SAM parser to use it.

=head1 EXAMPLES

    # Create a parser
    my $file_parser = GenOO::Data::File::SAM->new(
        file          => 'file.sam',
        records_class => 'GenOOx::Data::File::SAMstar::Record'
    );

    # Loop on the records of the file
    while (my $record = $file_parser->next_record) {
        # $record is now an instance of GenOOx::Data::File::SAMstar::Record.
        print $record->cigar."\n"; # name
        print $record->flag."\n"; # flag
        print $record->number_of_mappings."\n"; # new stuff not present by default in GenOO
    }

=cut

# Let the code begin...

package GenOOx::Data::File::SAMbwa;


#######################################################################
#######################   Load External modules   #####################
#######################################################################
use Modern::Perl;


1;
