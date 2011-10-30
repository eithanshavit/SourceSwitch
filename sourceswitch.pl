use strict;
use warnings;
use Cwd;
use File::Copy;

### edit with your own paths

### add as many vars as needed, i.e.:
# my $var_a = 'eithans';
# my $var_b = 'android_platform_178';

### create the default destination with your vars, i.e.:
# my $destination = "\\\\home\\src\\$a\\$b\\src\\kernel\\linux-2.6.32";

my $root = substr($ARGV[0],1,-1); # get root of source tree from command line

# Print welcome info
print "\n";
print "Source Switch\n";
print "---------------\n";
print "Source is :      $root\n";
print "Destination is : $destination\ \n";
print "\n";
print "OK? (y=copy files, l=list files, n=abort): ";

my $ask = <STDIN>; #get input from console
chomp $ask;
print "\n";
my $islist = "list";
if ($ask eq "y")
{
	$islist = "nolist";
	rec($root,"");
	print "---------------\n";
	print "---------------\n";
	print "Success!\n";
	sleep 2;
}
if ($ask eq "l")
{
	# listing on
	$islist = "list";
	rec($root,"");
	print "---------------\n";
	print "---------------\n";
	print "Folder listed. Press any key to continue...\n";
	my $wait = <STDIN>;
}
if (($ask ne "l") && ($ask ne "y"))
{
	print "---------------\n";
	print "---------------\n";
	print "Aborted\n";
	sleep 2;
}

sub rec{
	my $source = shift;
	my $relative_dir = shift;
	opendir (DIR, $source) or die "Cannot open the source folder for reading:$!\n"; 
	my @files = sort grep {!/^\.{1,2}$/} readdir(DIR); 
	closedir (DIR);
	
	for (@files){
	{ 
		my $full_path = "$source\\$_"; 
		my $new_file = "$destination$relative_dir\\$_";
		if (-d $full_path)
		# if &_ is dir
		{ 
			# print("  dir:   $full_path\n");
			# print("create dir -> $new_file\n");			
			# mkdir "$new_file" or die "Folder Cannot be created";
			rec($full_path,"$relative_dir\\$_");
			
		}
		else
		# if &_ is file
		{ 
			# print("  copy to :  -> $new_file\n"); 
			if ($islist eq "list")
			{
				print("file :     $relative_dir\\$_\n"); 
				# print("$new_file\n"); 
			}
			else 
			{
				print("$relative_dir\\$_\n"); 
				# print("$full_path, $new_file\n"); 
				# sleep 5;
				copy($full_path, $new_file) or die "File cannot be copied - check if dir exists. ";
			}
		} 
	} 
}
}
