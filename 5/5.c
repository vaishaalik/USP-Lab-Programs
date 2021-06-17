#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>

static void charatatime(char *);
int main(void)
{
	pid_t pid;
	if ((pid = fork()) < 0)
	{
		printf("fork error");
	}
	else if (pid == 0)
	{
		charatatime("Output from child\n\n");
	}
	else
	{
		charatatime("Output from parent\n\n");
	}
	return 0;
}

static void charatatime(char *str)
{
	char *ptr;
	int c;
	setbuf(stdout, NULL);
	for (ptr = str; (c = *ptr++) != 0; )
		putc(c, stdout);
}
