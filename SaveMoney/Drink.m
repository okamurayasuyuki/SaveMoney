//
//  Drink.m
//  SaveMoney
//
//  Created by HARADA SHINYA on 11/2/12.
//  Copyright (c) 2012 HARADA SHINYA. All rights reserved.
//

#import "Drink.h"

@implementation Drink

//singleton
+(id)shared
{
    static Drink *drink;
    if (!drink){
        drink = [[Drink alloc] init];
        NSMutableDictionary *drip = [@{@"name" : @"Drip Coffee",@"price" : @3.0} mutableCopy];
        NSMutableDictionary *green = [@{@"name" : @"Green Tea",@"price" : @4.0} mutableCopy];
        NSMutableDictionary *cafe = [@{@"name" : @"Cafe late",@"price" : @3.5} mutableCopy];
        NSMutableDictionary *cocoa = [@{@"name" : @"Cocoa", @"price" : @3.0} mutableCopy];
        NSMutableDictionary *tea = [@{@"name" : @"Tea", @"price" : @3.0} mutableCopy];
        drink.types = [@[drip,green,cafe,cocoa,tea] mutableCopy];
    }
    return drink;
}

-(float)priceForCoffee:(NSString *)name
{
    float currentPrice;
    if ([name isEqual:@"Drip Coffee"]){
        currentPrice = 3.0;
    }else if ([name isEqual:@"Green Tea"]){
        currentPrice = 4.0;
    }else if ([name isEqual:@"Tea"]){
        currentPrice = 3.0;
    }else if ([name isEqual:@"Cafe late"]){
        currentPrice = 3.5;
    }
    return currentPrice;
}

-(void)performCreateWith:(NSString *)name
{
    NSString *uuid = [[User alloc] uuid];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/drinks/",BASE_URL,uuid]];
    
    NSString *paramStr = [NSString stringWithFormat:@"price=%.2f&type=%@",[self priceForCoffee:name],name];
    
    NSData *params = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:params];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}



-(void)performTotalPrice
{
    NSString *uuid = [[User alloc] uuid];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/drinks/total_price/",BASE_URL,uuid]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.totalPrice = [[JSON valueForKey:@"total"] floatValue];
        [self.delegate updateCurrentPriceLabel];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",[error localizedDescription]);
        [[Helper alloc] showNetWorkErrorAlertView];
    }];
    
    [operation start];
    
}





-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // update total price
    [self performTotalPrice];
    NSLog(@"self.delegate is %@",self.hvcDelegate);
    if ([self.hvcDelegate respondsToSelector:@selector(didRefreshPage)]){
        [self.hvcDelegate didRefreshPage];
    }else{
        NSLog(@"not response!");
    }
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error %@",[error localizedDescription]);
    
//    [[Helper alloc] showNetWorkErrorAlertView];
}




@end
