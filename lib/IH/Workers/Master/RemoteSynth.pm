package IH::Workers::Master::RemoteSynth;
use Moo;
extends 'IH::Workers::Base';
use IH::Google::Synth;
use IH::Interfaces::Voice;
use Data::Dumper;
use Module::Load;

=head1 NAME

IH::Workers::Master::RemoteSynth - Processes the voice hypothesis thru a defined parser

=head1 DESCRIPTION

This Object implement process() that is called by the master node to parse and process the given command


=head1 ARGUMENTS 

RemoteSynth implements the IH::Workers::Master::Base arguments and implement the follow one

=over
=item GSynth() 
Get/Set the used Synthetizer (defaults to IH::Google::Synth)
=back
=item Parser()
Get/Set the parser used to process the command (default loaded from Config)
=back

=head1 FUNCTIONS
=over
=item process()
Process the request with the parser specified in the config file
=back


=cut

has 'GSynth' => (
    is      => "rw",
    default => sub {
        return IH::Google::Synth->new;
    }
);
has 'Parser' => ( is => "rw", );

sub BUILD {
    my $self = shift;
    my $Parser
        = 'IH::Parser::'
        . $self->Config->DBConfiguration->{'database_backend'};
    load $Parser;
    $Parser
        = $Parser->new( Config => $self->Config, Output => $self->Output );
    $Parser->prepare;
    $self->Parser($Parser);
    ##
    $self->GSynth->Language( $self->Config->DBConfiguration->{'language'} );
}

sub process {
    my $self = shift;
    my $fh   = shift;    ## IO::Socket
    my $audio;
    my $host = $fh->peerhost();

    my $Client = IH::Node->new( Config => $self->Config );
    $Client->selectFromHost($host);
    $self->Output->Node($Client);
    while (<$fh>) {
        $audio .= $_;
    }

    $self->GSynth->audiosynth($audio);
    my @hypotheses = @{ $self->GSynth->hypotheses() };
    if ( @hypotheses > 0 ) {

        $self->Parser->Node($Client);
        $self->Parser->Output( $self->Output );
        $self->Parser->parse(@hypotheses);

        #$self->Output->info( $hypotheses[0] );

        # $self->Output->info( "Google result for "
        #         . $host . ": "
        #         . join( "\t", @hypotheses ) . " "
        #         . $self->GSynth->Time
        #         . "s" );

        #Let's visualize the hypotesis for now
    }
}

1;