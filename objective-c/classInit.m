#import <Foundation/Foundation.h>

init main(void)
{
	[NSAutoreleasePool new];
	NSLog(@"main() entered");
	id init = [[Init alloc] init];
	init = [[Init alloc] init];
	return 0;
}
