//
//  TermStore.m
//  sportsguide
//
//  Created by prudhvi on 5/15/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import "TermStore.h"
#import "Term.h"

@interface TermStore ()

@property (nonatomic) NSMutableArray *privateTerms;

@end

@implementation TermStore

// If a programmer calls [[TermStore alloc] init], let him know the error of his ways
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[TermStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

+(instancetype)sharedStore {
    static TermStore *sharedStore = nil;

    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateTerms = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allTerms {
    return self.privateTerms;
}

- (Term *)createTerm {
    Term *termObj = [Term randomTerm];
    [self.privateTerms addObject:termObj];
    return termObj;
}

-(void)loadAllTerms {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *termsPath = [bundle pathForResource:@"SoccerballItem" ofType:@"plist"];
    
    NSArray *termsArray = [NSArray arrayWithContentsOfFile:termsPath];
    
    //NSLog(@"length : %lu", (unsigned long)termsArray.count);
    
    for (NSDictionary *termDict in termsArray) {
        Term *newTerm = [[Term alloc] initWithTermName:termDict[@"itemTerm"]
                                                detail:termDict[@"itemDetail"]
                                                termId:[termDict[@"itemId"] intValue]];
        [self.privateTerms addObject:newTerm];
        newTerm = nil;
    }
    termsArray = nil;
}

@end
