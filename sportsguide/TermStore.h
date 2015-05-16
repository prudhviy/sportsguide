//
//  TermStore.h
//  sportsguide
//
//  Created by prudhvi on 5/15/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Term;

@interface TermStore : NSObject

@property (nonatomic, readonly) NSArray *allTerms;

+(instancetype)sharedStore;

- (Term *)createTerm;
- (void)loadAllTerms;

@end

