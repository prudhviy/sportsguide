//
//  Term.m
//  sportsguide
//
//  Created by prudhvi on 5/15/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import "Term.h"

@implementation Term

- (void)setName:(NSString *)str {
    _name = str;
}
- (NSString *)name {
    return _name;
}

- (void)setDetail:(NSString *)str {
    _detail = str;
}

- (NSString *)detail {
    return _detail;
}

- (void)setTermId:(int)v {
    _termId = v;
}

- (int) termId {
    return _termId;
}

- (instancetype)init {
    return [self initWithTermName:@"dummy_term"];
}

- (instancetype)initWithTermName:(NSString *)name detail:(NSString *)value
                          termId:(int)idValue {
    // Call the superclass's designated initializer
    self = [super init];
    
    // Did the superclass's designated initializer succeed?
    if (self) {
        // Give the instance variables initial values
        _name = name;
        _detail = value;
        _termId = idValue;
    }
    
    // Return the address of the newly initialized object
    return self;
}

- (instancetype)initWithTermName:(NSString *)name {
    return [self initWithTermName:name detail:@"" termId:0];
}

+ (instancetype)randomTerm {
    // Create an immutable array of three adjectives
    NSArray *randomTermList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    // Create an immutable array of three nouns
    NSArray *randomDetailList = @[@"Bear", @"Spork", @"Mac"];
    
    // Get the index of a random term/detail from the lists
    // Note: The % operator, called the modulo operator, gives
    // you the remainder. So adjectiveIndex is a random number
    // from 0 to 2 inclusive.
    NSInteger termIndex = arc4random() % [randomTermList count];
    NSInteger detailIndex = arc4random() % [randomDetailList count];
    
    // Note that NSInteger is not an object, but a type definition
    // for "long"
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            [randomTermList objectAtIndex:termIndex],
                            [randomDetailList objectAtIndex:detailIndex]];
    
    int randomId = arc4random() % 100;
    
    Term *newTerm = [[self alloc] initWithTermName:randomName
                                       detail:randomName
                                         termId:randomId];
    return newTerm;
}

@end
