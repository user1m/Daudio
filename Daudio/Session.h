//
//  Session.h
//  Daudio
//
//  Created by Claudius Mbemba on 12/24/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MPMediaItem;

typedef NS_ENUM(NSUInteger, TrackNumber) {
    TrackOne, TrackTwo
};

@interface Session : NSCoder
@property (nonatomic, strong) MPMediaItem *firstTrack;
@property (nonatomic, strong) MPMediaItem *secondTrack;
@property BOOL isNewSession;

- (UIImage *)getArt:(TrackNumber)track size:(CGSize)size;

@end
