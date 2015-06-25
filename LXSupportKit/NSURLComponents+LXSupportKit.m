//
//  NSURLComponents+LXSupportKit.m
//  LXSupportKit
//
//  Created by Stan Chang Khin Boon on 24/6/15.
//  Copyright © 2015 lxcid. All rights reserved.
//

#import "NSURLComponents+LXSupportKit.h"

#import "LXURLQueryItem.h"

@implementation NSURLComponents (LXSupportKit)

#pragma mark - Class

+ (NSCharacterSet *)queryNameValueAllowedCharacterSet {
    static NSCharacterSet *queryNameValueAllowedCharacterSet;
    if (!queryNameValueAllowedCharacterSet) {
        NSMutableCharacterSet *mutableQueryNameValueAllowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [mutableQueryNameValueAllowedCharacterSet removeCharactersInString:@"&="];
        queryNameValueAllowedCharacterSet = [mutableQueryNameValueAllowedCharacterSet copy];
    }
    return queryNameValueAllowedCharacterSet;
}

#pragma mark - Public

- (void)setLx_queryItems:(NSArray * __nullable)queryItems {
    self.percentEncodedQuery = [self lx_percentEncodedQueryStringFromQueryItems:queryItems];
}

- (nullable NSArray *)lx_queryItems {
    return [self lx_queryItemsFromPercentEncodedQueryString:self.percentEncodedQuery];
}

- (NSString *)lx_string {
    return self.URL.absoluteString;
}

#pragma mark - Private

- (NSString *)lx_percentEncodedQueryStringFromQueryItems:(NSArray *)queryItems {
    if (!queryItems) {
        return nil;
    }
    
    if (queryItems.count == 0) {
        return @"";
    }
    
    NSCharacterSet *queryNameValueAllowedCharacterSet = [[self class] queryNameValueAllowedCharacterSet];
    
    NSMutableString *percentEncodedQueryString = [[NSMutableString alloc] init];
    BOOL isFirstQueryItem = YES;
    for (LXURLQueryItem *queryItem in queryItems) {
        if (isFirstQueryItem) {
            isFirstQueryItem = NO;
        } else {
            [percentEncodedQueryString appendString:@"&"];
        }
        
        NSString *name = [queryItem.name stringByAddingPercentEncodingWithAllowedCharacters:queryNameValueAllowedCharacterSet];
        [percentEncodedQueryString appendString:name];
        
        NSString *value = [queryItem.value stringByAddingPercentEncodingWithAllowedCharacters:queryNameValueAllowedCharacterSet];
        if (value) {
            [percentEncodedQueryString appendFormat:@"=%@", value];
        }
    }
    return [percentEncodedQueryString copy];
}

- (NSArray *)lx_queryItemsFromPercentEncodedQueryString:(NSString *)percentEncodedQueryString {
    if (!percentEncodedQueryString) {
        return nil;
    }
    
    if (percentEncodedQueryString.length == 0) {
        return @[];
    }
    
    NSMutableArray *queryItems = [[NSMutableArray alloc] init];
    NSArray *keyValuePairs = [percentEncodedQueryString componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in keyValuePairs) {
        NSArray *keyValueArray = [keyValuePair componentsSeparatedByString:@"="];
        switch (keyValueArray.count) {
            case 0:
            case 1: {
                NSString *name = keyValueArray.firstObject;
                name = [name stringByRemovingPercentEncoding];
                LXURLQueryItem *queryItem = [LXURLQueryItem queryItemWithName:name ?: @"" value:nil];
                [queryItems addObject:queryItem];
            } break;
            case 2: {
                NSString *name = keyValueArray[0];
                name = [name stringByRemovingPercentEncoding];
                NSString *value = keyValueArray[1];
                value = [value stringByRemovingPercentEncoding];
                LXURLQueryItem *queryItem = [LXURLQueryItem queryItemWithName:name value:value];
                [queryItems addObject:queryItem];
            } break;
            default: {
                NSString *name = keyValueArray[0];
                name = [name stringByRemovingPercentEncoding];
                NSRange valueRange = NSMakeRange(1, keyValueArray.count - 1);
                NSString *value = [[keyValueArray subarrayWithRange:valueRange] componentsJoinedByString:@"="];
                value = [value stringByRemovingPercentEncoding];
                LXURLQueryItem *queryItem = [LXURLQueryItem queryItemWithName:name value:value];
                [queryItems addObject:queryItem];
            } break;
        }
    }
    return [queryItems copy];
}

@end
