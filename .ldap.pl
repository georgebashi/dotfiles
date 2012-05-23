#!/usr/bin/perl

use strict;
use Net::LDAP;

use constant HOST => 'ldap.semantico.net';
use constant BASE => 'dc=semantico,dc=com';

{
  print "Searching database... ";
  my $name = shift || die "Usage: $0 filter\n";
  my $ldap = Net::LDAP->new( HOST, onerror => 'die' ) 
                || die "Cannot connect: $@";
  $ldap->bind() or die "Cannot bind: $@";
  my $msg = $ldap->search( base => BASE, 
                           filter => "(|(cn=*$name*)(uid=*$name*)(mail=*$name*))" );
  my @entries = ();
  foreach my $entry ( $msg->entries() ) {
    push @entries,
        { email => $entry->get_value( 'mail' ),
          cn    => $entry->get_value( 'cn' ) };
  }
  $ldap->unbind();
  print scalar @entries, " entries found.\n";
  foreach my $entry ( @entries ) {
    print "$entry->{email}\t$entry->{cn}\n";
  }
}

