//
//  Destination.m
//  SimpleTableViewController-MVC
//
//  Created by Dylan Sewell on 8/12/19.
//  Copyright © 2019 dylansewell. All rights reserved.
//

#import "Destination.h"

@implementation Destination
-(instancetype)initWithName:(NSString *)name {
  self = [super init];
  if (self) {
    _name = [name copy];
  }
  return self;
}

@end
