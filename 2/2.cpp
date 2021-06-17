#define _POSIX_SOURCE 
#define _POSIX_C_SOURCE 199009L 
#include<iostream> 
#include<unistd.h>
using namespace std; 
int main() 
{ 
	#ifdef _POSIX_JOB_CONTROL 
	cout<<"System Supports Job Control feature.\n\n";
	#else 
	cout<<"System does not support job control.\n\n"; 
	#endif 

	#ifdef _POSIX_SAVED_IDS 
	cout<<"System Supports saved set-UID and saved set-GID\n\n";
	#else 
	cout<<"System does not support saved set-UID.\n\n"; 
	#endif 

	#ifdef _POSIX_CHOWN_RESTRICTED 
	cout<<"System Supports Change Ownership feature :: "<<_POSIX_CHOWN_RESTRICTED<<".\n\n"; 
	#else 
	cout<<"System does not support change Ownership feature.\n\n"; 
	#endif 

	#ifdef _POSIX_NO_TRUNC 
	cout<<"System Supports Path truncation option :: "<<_POSIX_NO_TRUNC<<".\n\n"; 
	#else 
	cout<<"System doesnot support Path truncation. \n\n"; 
	#endif 

	#ifdef _POSIX_VDISABLE 
	cout<<"System Supports Disable Character for files."<<_POSIX_VDISABLE<<"\n\n";  
	#else 
	cout<<"System doesnot support Disable Characters. \n\n"; 
	#endif	 
	
	return 0; 
} 
