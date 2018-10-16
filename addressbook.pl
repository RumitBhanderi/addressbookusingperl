
use strict;
use warnings;
use diagnostics;
use Entry;



package structure;

our $list;
our @entries;     

sub AddEntry{
my $entry =  new Entry();     

print ( "Please enter in firstname: \n");
my $first = <STDIN>;
chomp $first;	
$entry->firstName($first);

print ("Lastname: \n");
my $last = <STDIN>;
chomp $last;
$entry->lastName($last);

print("Home Phone: in the form xxxx-xxxxxx \n");
	my $phone = <STDIN>;
	chomp $phone;
	
	my $test = validatePhone ($phone);
	if($test ne 0){
	my @values = search($test,3);
	my $check = pop(@values);
	
        if ($check){
	print ("User already in Address Book\n\n");
	return 0;
	}else{
	$entry->phone($test);
	}
	}else{
	my $flag =0;
	while($flag == 0){
		errorMessage();
		my $newphone = prompt();
		#must dereference hard reference to get string value use $$ 
		my $test = validatePhone($$newphone);

                	if($test ne 0){
			chomp $test;
			my @values = search($test,3);
	
			my $check = pop(@values);
	
        		if ($check){
			print ("User already in Address Book\n\n");
			return 0;
			}else{
	
			$entry->phone($test);
 			$flag=1;
			}
			}#end of test

			if($flag == 1){ 

			{last;} #break out of loop if received correct input
			}
	}
}


print("Mobile phone in the form xx-xxxxxxxxxx \n");
		my $mobile = <STDIN>;
		chomp $mobile;
		$test = validateMobile($mobile);
		if($test ne 0){
		$entry->mobile($test);
		}else{
		my $flag =0;
		while($flag == 0){
		errorMessage();
		my $newmobile = prompt();
		
		my $test = validatePhone($$newmobile);

                	if($test ne 0){
			chomp $test;
			
			$entry->mobile($test);
 			$flag=1;
			}

			if($flag == 1){ 

			{last;} 
			}
	}
}

print ("Home address: street,city and state\n");
my $address = <STDIN>;
chomp $address;
$entry->address($address);


print("Please enter a valid  Zipcode in the form xxxxxx \n");
my $zip = <STDIN>;
		chomp $zip;
		$test = validateZipcode($zip);
		if($test ne 0){
		$entry->zipcode($test);
		}else{
		my $flag =0;
		while($flag == 0){
		errorMessage();
		my $newzip = prompt();
		#must dereference hard reference to get string value use $$ 
		my $test = validateZipcode($$newzip);

                	if($test ne 0){
			chomp $test;
			
			$entry->zipcode($test);
 			$flag=1;
			}#end of test

			if($flag == 1){ 

			{last;} #break out of loop if received correct input
			}
	}
}

print("Please enter a valid Date of Birth in the form xx/xx/xxxx \n");
my $dob = <STDIN>;
		chomp $dob;
		$test = validateDate($dob);
		if($test ne 0){
		$entry->dob($test);
		}else{
		my $flag =0;
		while($flag == 0){
		errorMessage();
		my $newdate = prompt();
		#must dereference hard reference to get string value use $$ 
		my $test = validateDate($$newdate);

                	if($test ne 0){
			chomp $test;
			
			$entry->dob($test);
 			$flag=1;
			}#end of test

			if($flag == 1){ 

			{last;} #break out of loop if received correct input
			}
	}
}

print ("Please enter this persons yearly salary \n");
my $salary = <STDIN>;
chomp $salary;
$entry->salary($salary);



push @entries, $entry;

  update();
}


sub deleteFile{
    
    my $output="addressbook.txt";
    
    open(FH,">$output") || die("Cannot Open File");
    my ($self) = @_;
    
    close $output;
    close(FH);
    
}


sub update{

my @sorted_entries;
deleteFile();
@sorted_entries = sort { $a->firstName cmp $b->firstName } @entries;

foreach(@sorted_entries){
$_->write();
}

}
#******************************************************************
#sorting routines
#All user to sort by all fields
#*****************************************************************

sub sort{
print("Please select field to sort by \n");
print("first name                1\n");
print("last name                 2\n");
print("Home phone                3\n");
print("Mobile phone              4\n");
print("Address                   5\n");
print("Zipcode                   6\n");
print("DOB                       7\n");
print("Salary                    8\n");

my @sorted_entries; 
my $select = <STDIN>;
#Store string of attribute we are sorting 
my @sortby;
$sortby[0]="First Name";
$sortby[1]="Last Name";
$sortby[2]="Home Phone";
$sortby[3]="Mobile Phone";
$sortby[4]="Address";
$sortby[5]="Zip code";
$sortby[6]="DOB";
$sortby[7]="Salary";
my @order = qw(Ascending Descending);
print("Ascending or Descending\n");
print("Ascending            1\n");
print("Descending           2\n");
my $direction =<STDIN>;



if( $select == 1 and $direction == 1){

@sorted_entries = sort { $a->firstName cmp $b->firstName } @entries;
}elsif( $select == 1 and $direction ==2 ){
@sorted_entries = sort { $b->firstName cmp $a->firstName } @entries;
}elsif( $select == 2 and $direction == 1){
@sorted_entries = sort { $a->lastName cmp $b->lastName } @entries;
}elsif($select == 2 and $direction == 2 ){
@sorted_entries = sort { $b->lastName cmp $a->lastName } @entries;
}elsif( $select == 3 and $direction == 1 ){
@sorted_entries = sort { $a->phone cmp $b->phone } @entries;
}elsif( $select == 3 and $direction == 2){
@sorted_entries = sort { $b->phone cmp $a->phone } @entries;
}elsif($select == 4 and $direction == 1 ){
@sorted_entries = sort { $a->mobile cmp $b->mobile } @entries;
}elsif( $select == 4 and $direction ==2 ){
@sorted_entries = sort { $b->mobile cmp $a->mobile } @entries;
}elsif( $select == 5 and $direction == 1){
@sorted_entries = sort { $a->Address cmp $b->Address } @entries;
}elsif($select == 5 and $direction == 2 ){
@sorted_entries = sort { $b->Address cmp $a->Address } @entries;
}elsif( $select == 6 and $direction ==1 ){
@sorted_entries = sort { $a->zipcode <=> $b->zipcode } @entries;
}elsif( $select == 6 and $direction == 2){
@sorted_entries = sort { $b->zipcode <=> $a->zipcode } @entries;
}elsif($select == 7 and $direction == 1 ){
@sorted_entries = sort { $a->dob cmp $b->dob } @entries;
}elsif( $select == 7 and $direction == 2 ){
@sorted_entries = sort { $b->dob cmp $a->dob } @entries;
}elsif( $select == 8 and $direction == 1){
@sorted_entries = sort { $a->salary <=> $b->salary } @entries;
}elsif($select == 8 and $direction == 2 ){
@sorted_entries = sort { $b->salary <=> $a->salary } @entries;
}

print ("Sorting by ", $sortby[$select-1]," in ",$order[$direction-1]," order\n\n");

#foreach my $value(@sorted_entries ){
  foreach(@sorted_entries){

	format SORTER= 
First Name: @<<<<<<<<<<<<<<<<<<<<<<<        Last Name: @>>>>>>>>>>>>>>>>>>
      $_->firstName,                                   $_->lastName
Home Phone: @<<<<<<<<<<<<<<<<<<<<<<<	    Mobile Phone: @>>>>>>>>>>>>>>>
      $_->phone,					  $_->mobile
Address:    @<<<<<<<<<<<<<<<<<<<<<<<	    Zip code:  @>>>>>>>>>>>>>>>>>>
      $_->address,			    	       $_->zipcode
DOB:	    @<<<<<<<<<<<<<<<<<<<<<<<	    Salary:    @###############.##
      $_->dob,					       $_->salary
        
.
write;

}
        

}


sub load{
	#create a flag to find errors when loading 
	my $loaded = 0;
	my $tester;
	
	open (PWFILE,"addressbook.txt");
	while (<PWFILE>) {
    	chomp;
    	    my $loader = new Entry();
	    my @fields = split(":", $_);
	   
	    my @names = split(" ", $fields[0]);

            
	    
	    $loader->firstName($names[0]);
	    $loader->lastName($names[1]);
            $loader->phone($fields[1]);
            $loader->mobile($fields[2]);
            
            my @zip = split(" ",$fields[3]);
            my $mystr="";
  	    my $str=0;
            foreach $str (@zip){
		$tester = validateZipcode($str);
		if($tester ne 0){
		$loader->zipcode($tester);
		}else{
                $mystr.=$str ." ";
		}
	    }
            $loader->address($mystr);
	    $loader->dob($fields[4]);
            $loader->salary($fields[5]);

	    #validate document
            if($names[0] and $names[1] and $fields[1] and $fields[2] and $fields[3]
		 and $mystr and $tester){
		$loaded =1;
	     }else{
		$loaded =0;
	     }
            #put obj into array only if document is well formed 
            if ( $loaded == 1 ){
            push @entries,$loader;
	    }

	}
}


sub traverse{
 my $counter=0;
foreach(@entries){

	format = 
First Name: @<<<<<<<<<<<<<<<<<<<<<<<        Last Name: @>>>>>>>>>>>>>>>>>>
      $_->firstName,                                   $_->lastName
Home Phone: @<<<<<<<<<<<<<<<<<<<<<<<	    Mobile Phone: @>>>>>>>>>>>>>>>
      $_->phone,					  $_->mobile
Address:    @<<<<<<<<<<<<<<<<<<<<<<<	    Zip code:  @>>>>>>>>>>>>>>>>>>
      $_->address,			    	       $_->zipcode
DOB:	    @<<<<<<<<<<<<<<<<<<<<<<<	    Salary:    @###############.##
      $_->dob,					       $_->salary
        
.
write;
$counter++;
}
	print ("Showing " . $counter . " record(s)\n\n");

}

sub validateMobile {
   my $fh =shift;
if($fh =~ /\d{2}-\d{10}/){
return $&;
}
else{
return 0;
}
}#end sub validatePhone
sub validatePhone {
   my $fh =shift;
if($fh =~ /\d{4}-\d{6}/){
return $&;
}
else{
return 0;
}
}

sub validateZipcode {
   my $fh =shift;
if($fh =~ /(^\d{6}$)/){
return $&;
}
else{
return 0;
}
}
sub validateDate {
   my $fh =shift;
if( $fh =~ /\b(0?[1-9]|[12][0-9]|3[01])[\-\/](1[0-2]|0?[1-9])[\-\/]((19|20)\d{2})/ ){

return $&;
}
else{
return 0;
}
}

sub deleteEntry{

my $match = $_[0];
chop $match;
my $select = $_[1];
chop $select;
my $pos =0;
my @matches;
my $ans;
print("\n"); 
foreach (@entries){

	if ( $select == 1){
	 	if( $_->firstName eq $match){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		
		}
	}elsif( $select == 2){
		if($_->lastName eq $match) {
		$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif( $select == 3 ) {
		if($_->phone eq $match ) {
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif( $select == 4 ){
		if($_->mobile eq $match ){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif($select == 5 ){
		if($_->address eq $match){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif( $select == 6 ){
		if($_->zipcode eq $match){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif( $select == 7 ){
		if($_->salary eq $match){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}
$pos++;

}


return @matches;

}

sub deleteEntryPrompt{
print("Delete Entry.....\n");
print ("Please select a search criteria below to query entry you wish to delete...\n");
print("first name                1\n");
print("last name                 2\n");
print("Home phone                3\n");
print("Mobile phone              4\n");
print("Address                   5\n");
print("Zipcode                   6\n");
#print("DOB                       7\n");
print("Salary                    8\n");

my $select = <STDIN>;

print"Please type filter content below\n";
my $filter =<STDIN>;

deleteFile();
deleteEntry($filter,$select);
update();
}

sub query{

print ("Please select a search criteria below\n");
print("first name                1\n");
print("last name                 2\n");
print("Home phone                3\n");
print("Mobile phone              4\n");
print("Address                   5\n");
print("Zipcode                   6\n");
#print("DOB                       7\n");
print("Salary                    8\n");

my $select = <STDIN>;

print"Please type filter content below\n";
my $filter =<STDIN>;

my @found = search($filter,$select);

 my $counter=0;
foreach(@found){

	format FILTER = 
First Name: @<<<<<<<<<<<<<<<<<<<<<<<        Last Name: @>>>>>>>>>>>>>>>>>>
      $_->firstName,                                   $_->lastName
Home Phone: @<<<<<<<<<<<<<<<<<<<<<<<	    Mobile Phone: @>>>>>>>>>>>>>>>
      $_->phone,					  $_->mobile
Address:    @<<<<<<<<<<<<<<<<<<<<<<<	    Zip code:  @>>>>>>>>>>>>>>>>>>
      $_->address,			    	       $_->zipcode
DOB:	    @<<<<<<<<<<<<<<<<<<<<<<<	    Salary:    @###############.##
      $_->dob,					       $_->salary
        
.
write;
$counter++;
}
	print ("Found " . $counter . " record(s)\n\n");
}

sub search{
 
my $match = $_[0];
chop $match;
my $select = $_[1];

my @matches;
my $value = new Entry();
foreach $value (@entries){

	if ( $select == 1){
	 	if( $value->firstName eq $match){
			push(@matches, $value);
		
		}
	}elsif( $select == 2){
		if($value->lastName eq $match) {
			push(@matches,$value);
		}
	}elsif( $select == 3 ) {
		if($value->phone eq $match ) {
			push(@matches,$value);
		}
	}elsif( $select == 4 ){
		if($value->mobile eq $match ){
			push(@matches,$value);
		}
	}elsif($select == 5 ){
		if($value->address eq $match){
			push(@matches,$value);
		}
	}elsif( $select == 6 ){
		if($value->zipcode eq $match){
			push(@matches,$value);
		}
	}elsif( $select == 7 ){
		if($value->salary eq $match){
			push(@matches,$value);
		}
	}

}


return @matches;

}
sub prompt{
printf "Please enter valid data\n";
my $input = <STDIN>;
return \$input;
}


sub errorMessage{
printf("Invalid Entry! Please try again.\n");
}

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








