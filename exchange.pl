#!/usr/bin/perl

use strict;

use Net::SMTP; 
use Data::Dumper;

srand();

# Replace with valid server and email address.
use constant MAIL_SERVER => 'smtp.whatever.com';
use constant FROM_EMAIL  => 'from@myemail.com';

my $group = shift;
my $DEBUG = 1; # Set to 1 for debug output and no email sent.


# An array containing the names of people exchanging gifts.  Add
# as many entries as you need for your exchange group.
# person and pickedby fields must be -1 by default.

my @people = (
	{ 
	  'name' => 'Edward',
	  'email' => 'to@myemail.com',
	  'person' => -1,
	  'pickedby' => -1
	},
	{
	  'name' => 'Andrew',
	  'email' => 'to@myemail.com',
	  'person' => -1,
	  'pickedby' => -1
	},
	{
	  'name' => 'Brian',
	  'email' => 'to@myemail.com',
	  'person' => -1,
	  'pickedby' => -1
	},
	{
	  'name' => 'Terrill',
	  'email' => 'to@myemail.com',
	  'person' => -1,
	  'pickedby' => -1
	}
);

# Tracks which array entry is being worked on and as a check
# to be sure a record is not selected by itself randomly.
my $counter = 0;

foreach my $person (@people) {

	# To protect against an infinite loop should the pairings not
	# work out correctly.
	my $abortcounter = 0;
	
	# Loop until a match is found.
	my $match = 0;
	while ($match == 0) {
	
		my $random = int(rand(scalar @people));
		
		if ($random != $counter && $people[$random]{'pickedby'} == -1) {
			$person->{'person'} = $random;
			$people[$random]{'pickedby'} = $counter; 
			
			$match = 1;
		}
		
		# After a reasonable number of tries, end attempt at matching.
		$abortcounter++;
		if ($abortcounter > 30 && $match == 0) {
			die 'Bad pairing... aborting.  Run again.  No emails were sent.';
		}
	
	}
	
	$counter++;

}

if ($DEBUG == 1) {

	print "Pairings:\n";
	print Dumper(\@people);
	print "\nNo Emails were sent!\n";
	
} else {

	foreach my $person (@people) {
	
		my $smtp = Net::SMTP->new(MAIL_SERVER);
	
		$smtp->mail($person->{'email'});
		$smtp->to($person->{'email'});
	
		$smtp->data();
		$smtp->datasend("To: $person->{'email'}\n");
		$smtp->datasend("From: " . FROM_EMAIL . "\n");
		$smtp->datasend("Subject: $person->{'name'}, your person is...\n\n");
		$smtp->datasend("$people[$person->{'person'}]->{'name'}\n\n\n\n");
		$smtp->datasend("Do not reply to this email, or use it for any future contact.");
		$smtp->dataend();
	
		$smtp->quit;
	}

}

