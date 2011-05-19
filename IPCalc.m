//
//  IPCalc.m
//  ipCalc
//
//  Created by C.H Lee on 5/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IPCalc.h"
#include <arpa/inet.h>

#define GETBIT(value, bit) ((value>>(32-bit-1))&0x00000001)

@implementation IPCalc

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

-(NSArray*)calcFrom:(NSUInteger)ip1 to:(NSUInteger)ip2 {

	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:8];
	
	unsigned int start = ip1;
	unsigned int end = ip2;
	unsigned int base = start;
	unsigned int ip;
	unsigned int step;
	unsigned int thirtytwobits = 0xffffffff;
	unsigned int before;
	unsigned int after;

	struct in_addr addr;

	while (base <= end)
	{
		step = 0;
		while ((base | (1 << step))  != base) {
			if ((base | (((~0) & thirtytwobits) >> (31-step))) > end) {
				break;
			}
			step++;
		}
		ip = base;
		addr.s_addr = NTOHL(ip);
		NSString* str = [NSString stringWithFormat:@"%s/%d", inet_ntoa(addr), 32-step];
		[arr addObject:str];
		before = base;
		base += 1 << step;
		after = base;
		if (before > after) {
			break;
		}
	}
	//GZLogFunc1(arr);
	return arr;
}

@end
