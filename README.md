Gift Exchange Automater
=======================

This is a simple Perl script for the purpose of name selection for
gift exchanges.  In addition to just selecting the pairings, the
script can also email each person to inform them who they will be
buying a gift for.

Making It Happen in 6 Easy Steps
--------------------------------

1. Download the script to your computer and open in a text editor.

2. Set the MAIL_SERVER and FROM_EMAIL constants.  They should match whatever you use in your email program (SMTP).

3. The $DEBUG variable is set to 1 by default.  Run it the first time like this to ensure it's working.  Set to 0 when you want emails to be sent out.

4. The @people array needs to be filled with information about people in your exchange.  Add as many as you need, making sure a name and email is provided, and the other two fields left as -1.

5. Open the command line, go to the folder where the script is located, and run:

	perl exchange.pl
	
6. Enjoy your gift exchange!

Requirements
------------

You'll need Perl, and the Data::Dumper and Net::SMTP modules.