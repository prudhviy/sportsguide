//
//  Term.h
//  sportsguide
//
//  Created by prudhvi on 5/15/15.
//  Copyright (c) 2015 gits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Term : NSObject {
    
    NSString *_name;
    NSString *_detail;
    int _termId;
    NSString *_video;
}

+ (instancetype)randomTerm;

- (void)setName:(NSString *)str;
- (NSString *)name;

- (void)setDetail:(NSString *)str;
- (NSString *)detail;

- (void)setTermId:(int)v;
- (int)termId;

- (void) setVideo:(NSString *)video;
- (NSString *)video;

// Designated initializer for Term
- (instancetype)initWithTermName:(NSString *)name detail:(NSString *)value
                          termId:(int)idValue termVideo:(NSString *)video;

- (instancetype)initWithTermName:(NSString *)name;

@end
