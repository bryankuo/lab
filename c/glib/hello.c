#include <glib.h>
#include <stdio.h>
int main(void)
{
//printf("hello world!\n");
GString *a = g_string_new("Justin");
GString *b = g_string_new("aab");
GString *c = g_string_sized_new(16);
char buf[16] = {'a','b','c',0};
GString *d = g_string_new(buf);
printf("%s %ld %ld\n", d->str, d->len, d->allocated_len);
//printf("%ld %ld\n", c->len, c->allocated_len);
gint i = 0;
for(i=0;i<3;i++)
{
 g_string_printf (c,"string_%d",i);
 printf("%s\n",c->str);
 //a = g_string_append(a, c->str); 
 //a = g_string_append(a, "aa");
 g_string_append_printf(a,"string_%d",i); 
}
printf("%s %ld %ld\n", a->str, a->len, a->allocated_len);
//g_string_free(b, FALSE);
g_string_free(a, FALSE);
printf("%s %ld %ld\n", b->str, b->len, b->allocated_len);
g_string_free(b, FALSE);
//printf("%s %ld %ld\n", b->str, b->len, b->allocated_len);
//printf("%s %ld %ld\n", c->str, c->len, c->allocated_len);
g_string_free(c, FALSE);
return 0;
}
