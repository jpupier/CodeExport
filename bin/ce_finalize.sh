# /bin/bash
# Final step when building CodeExport component, called by CE_BLD_Build method.
# Do not execute this script manually, it is called by CodeExport.

# Argument list:
# 1 - 4D application process ID

# Global vars
pidOf4D_l=$1


# Function declarations
ce_usage(){
	echo "Do not execute this script manually, it is called by CodeExport"
	exit 1
}


pause(){
   read -p 'Press [Enter] key to continue...'
}


ce_copyFiles(){
	component_dir='../component/CodeExport.4dbase'
	source_dir='../matrix/CodeExport.4dbase'
	
	# Files we need:
	#   -4DB
	#   -4DINDY
	
	echo 'Copying structure file...'
	cp "$source_dir/CodeExport.4DB" "$component_dir/CodeExport.4DB"
	
	echo 'Copying structure index file...'
	cp "$source_dir/CodeExport.4DIndy" "$component_dir/CodeExport.4DIndy"
	
	echo 'Build complete!'
	pause

	exit 0
}


ce_start(){
	numTries_l='.'
	is4DRunning_l=`ps -p $pidOf4D_l | wc -l`
	
	# Wait for 4D to quit.
	while [ $is4DRunning_l != 1 ]
	do
		clear
		
		# Let the user know what's happening, and how many times.
		echo "Waiting for 4D to quit$numTries_l"
		
		# Delay for 1 second
		sleep 1
		
		# Check to see if 4D is running.
		# Returns 2 if found, 1 if not.
		is4DRunning_l=`ps -p $pidOf4D_l | wc -l`
		
		numTries_l="$numTries_l."
		
		# If 4D is still running, loop again.
	done
		
	echo '4D has quit!'
	
	ce_copyFiles
}


# Begin actual script.

# Check for Argument; if not passed script was probably called manually.
if [ ! $# == 1 ]; then
	ce_usage
else
	ce_start
fi

