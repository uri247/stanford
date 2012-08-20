//
//  ImportViewController.m
//  SecGames
//
//  Created by Uri London on 8/20/12.
//  Copyright (c) 2012 Uri London. All rights reserved.
//

#import "ImportViewController.h"
#import "CryptoData.h"

@interface ImportViewController ()

@end


@implementation ImportViewController
@synthesize originalLabel = _originalLabel;


- (IBAction)importPressed {
    NSString* clear = [NSString stringWithUTF8String:symMsg1.msg];
    self.originalLabel.text = clear;
    
    NSMutableDictionary* keyAttr = [[NSMutableDictionary alloc] init];

    /*
    [keyAttr setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [keyAttr setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [keyAttr ]
    
    
    //======
    NSData * peerTag = [[NSData alloc] initWithBytes:(const void *)[peerName UTF8String] length:[peerName length]];
	NSMutableDictionary * peerPublicKeyAttr = [[NSMutableDictionary alloc] init];
	
	[peerPublicKeyAttr setObject:(id)kSecClassKey forKey:(id)kSecClass];
	[peerPublicKeyAttr setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
    
    
	[peerPublicKeyAttr setObject:peerTag forKey:(id)kSecAttrApplicationTag];
	[peerPublicKeyAttr setObject:publicKey forKey:(id)kSecValueData];
	[peerPublicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnPersistentRef];
    secItemAdd
     */
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setOriginalLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
