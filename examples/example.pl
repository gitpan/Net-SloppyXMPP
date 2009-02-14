#!/usr/bin/perl

use lib "../lib";
use Net::SloppyXMPP;
use Data::Dumper;

my $VERSION = '0.1.2.3';

my $xmpp = Net::SloppyXMPP->new(
  debug => 5,
  tickdelay => 0.25,
  domain => 'leafbridge.net',
  username => 'tester',
  password => 'tester',
  resource => "LeafBridgeClient-$VERSION",
  initialpresence => 'available',
  initialstatus => "LeafBridgeClient/$VERSION",
  message_callback => \&messageIn,
);
die qq(XMPP didn't create.\n) unless $xmpp;
my $xmppConnect = $xmpp->connect;
die qq(XMPP didn't connect.\n) unless $xmppConnect;

$xmpp->run(\&tick);

sub tick
{
  my $xmpp = shift;
  #warn "main tick!\n";
  my @presence = qw/available dnd away/;
  if ($xmpp->ready() && int(rand() * 100) == 50)
  {
    $xmpp->presence($presence[int(rand() * scalar(@presence))], 'Presence: '.time());
  }
}

sub messageIn
{
  my $xmpp = shift;
  my $data = shift;

  print Dumper($data);
}
