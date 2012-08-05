//
//  Operation.h
//  Calculator
//
//  Created by Uri London on 8/5/12.
//
//

#import <Foundation/Foundation.h>



@interface OperationTraits :NSObject
{
    NSString* _name;
    int _numOperands;
    SEL _sel;
}

+ (OperationTraits*)initWithName:(NSString*)name Num:(int)num Sel:(SEL)sel;
+ (NSArray*)all;
+ (OperationTraits*)find:(NSString*)name;
@end


@interface Operation : NSObject

@end
