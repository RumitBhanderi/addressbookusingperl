use strict;
use warnings;
use diagnostics;
use Entry;

package main;

#load file 
structure::load();
for(;;){


print ("\n	 AddressBook 		\n\n");
print("Please choice one of the following Options: \n");
print("Add a new entry            1\n");
print("Delete an existing entry   2\n");
print("Sorting                    4\n");
print("Search			   5\n");
print("Exit                       6\n");

my $input = <STDIN>;
chop ($input);

if($input){
	
	if ( $input == 1 ){
	  structure::AddEntry();
	}
	if( $input == 2 ) {
	   structure::deleteEntryPrompt();
	}
	if ( $input == 3 ) {
	   structure::traverse();
	}
	if ( $input == 4 ) {
	   structure::sort();
	}
	if( $input == 5 ) {
	   structure::query();
	}
	if ( $input == 6 ) {
	structure::update();
		last;}
	
	}
}	



