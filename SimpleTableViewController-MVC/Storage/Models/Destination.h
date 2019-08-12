//
//  Destination.h
//  SimpleTableViewController-MVC
//
//  Created by Dylan Sewell on 8/12/19.
//  Copyright © 2019 dylansewell. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Destination : NSObject

@property (nonatomic, copy) NSString *name;

-(instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
