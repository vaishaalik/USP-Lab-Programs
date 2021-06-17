// A simple C program to demonstrate working of setjmp() and longjmp()
#include<stdio.h>
#include<setjmp.h>
jmp_buf buf;

void func()
{
	printf("Example Program\n");
	// Jump to the point setup by setjmp
	longjmp(buf, 1);
	printf("Exit from setjmp and longjmp\n");
}

int main()
{
	// Setup jump position using buf and return 0
	if (setjmp(buf))
		printf("---> setjmp called <---\n");
	else
	{
		printf("---> longjmp called <---\n");
		func();
	}
	return 0;
}
