//
//  MTZWhatsNew.h
//
//  MTZWhatsNew created by Matt Zanchelli on 5/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

//
//  Based off of MTMigration created by Parker Wightman on 2/7/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

/*
 Copyright (c) 2012, Mysterious Trousers
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>

#import "MTZWhatsNewViewController.h"

typedef void (^MTZWhatsNewHandler)(NSDictionary *whatsNew);

@interface MTZWhatsNew : NSObject

///	Show what's new in this update, if anything.
/// @discussion Call this on every app launch to keep track of used versions.
+ (void)handleWhatsNew:(MTZWhatsNewHandler)whatsNewBlock;

///	Clears the last migration remembered by @c MTZWhatsNew. Causes migration to run from the beginning.
+ (void)reset;

@end
