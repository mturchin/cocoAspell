// ============================================================================
//  AspellOptionsWithLists.m
// ============================================================================
//
//	cocoAspell2
//
//  Created by Anton Leuski on 2/13/05.
//  Copyright (c) 2005-2008 Anton Leuski. All rights reserved.
//
//	Redistribution and use in source and binary forms, with or without
//	modification, are permitted provided that the following conditions are met:
//
//	1. Redistributions of source code must retain the above copyright notice, this
//	list of conditions and the following disclaimer.
//	2. Redistributions in binary form must reproduce the above copyright notice,
//	this list of conditions and the following disclaimer in the documentation
//	and/or other materials provided with the distribution.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//	ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//	 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ============================================================================

#import "AspellOptionsWithLists.h"
#import "MutableAspellList.h"

@interface AspellOptionsWithLists (MutableLists)
- (MutableAspellList*)mutableListForKey:(NSString*)inKey;
@end

@implementation AspellOptionsWithLists

// ----------------------------------------------------------------------------
//	
// ----------------------------------------------------------------------------

- (id)initWithAspellConfigNoCopy:(AspellConfig*)inConfig
{
	if (self = [super initWithAspellConfigNoCopy:inConfig]) {
		self.listCaches = [NSMutableDictionary dictionary];
	}
	return self;
}

// ----------------------------------------------------------------------------
//	
// ----------------------------------------------------------------------------

- (id)valueForKey:(NSString*)inKey
{
	if ([inKey hasPrefix:kMutableListPrefix]) {
		return [self mutableListForKey:inKey];
	} else {
		return [super valueForKey:inKey];
	}
}

// ----------------------------------------------------------------------------
//	
// ----------------------------------------------------------------------------

- (MutableAspellList*)mutableListForKey:(NSString*)inKey
{
	MutableAspellList*	list	= [self listCaches][inKey];
	if (!list) {
		Class	cc	= [StringController class];
		if ([inKey isEqualToString:[kMutableListPrefix stringByAppendingString:@"f_tex_command"]]) {
			cc	= [TeXCommandController class];
		}
		
		list	= [[MutableAspellList alloc] 
					initWithAspellOptions:self 
					key:inKey 
					controllerClass:cc];
		self.listCaches[inKey] = list;
	}
	return list;
}

@end
