#include <sys/types.h>
#include <regex.h>
#include <stdio.h>

// POSIX Bracket Expressions
// gcc -g reg.c -o reg

int main(int argc, char *argv[]){
        regex_t regex;
        int reti;
        char msgbuf[100];

/* Compile regular expression */
        //reti = regcomp(&regex, "^a[[:alnum:]]", 0);
	//reti = regcomp(&regex, "([[:alpha:]]{2,4})", 0);
	//reti = regcomp(&regex, "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$", 0);
	//reti = regcomp(&regex, "[[:alnum:] _-]{2,5}", REG_EXTENDED);
	reti = regcomp(&regex, argv[1], REG_EXTENDED);
	
	//reti = regcomp(&regex, "^(?=.{10,32})(?=.*\d).*$", 0);
	//reti = regcomp(&regex, "^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$", 0);
	//reti = regcomp(&regex, "^(?=.*\d).{4,8}$", 0); // Password must be between 4 and 8 digits long and include at least one numeric digit.
        if( reti ){ fprintf(stderr, "Could not compile regex\n"); exit(1); }
	fprintf(stdout, "%s\n", argv[1]);
/* Execute regular expression */
        //reti = regexec(&regex, "abc", 0, NULL, 0);
	fprintf(stdout, "%s\n", argv[2]);
	reti = regexec(&regex, argv[2], 0, NULL, 0);
        if( !reti ){
                puts("Match");
        }
        else if( reti == REG_NOMATCH ){
                puts("No match");
        }
        else{
                regerror(reti, &regex, msgbuf, sizeof(msgbuf));
                fprintf(stderr, "Regex match failed: %s\n", msgbuf);
                exit(1);
        }

/* Free compiled regular expression if you want to use the regex_t again */
	regfree(&regex);

        return 0;
}