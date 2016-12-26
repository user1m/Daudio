//
//  PlayerVCTests.m
//  Daudio
//
//  Created by Claudius Mbemba on 12/26/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PlayerViewController.h"
#import "PlayerView.h"

@interface PlayerVCTests : XCTestCase

@end

@implementation PlayerVCTests {
    PlayerViewController *sut;
}

- (void)setUp {
    [super setUp];
    //given
     sut = (PlayerViewController *)[[UIStoryboard storyboardWithName:NSStringFromClass([PlayerViewController class]) bundle:nil] instantiateInitialViewController];
    
    //when
    [sut view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVCDragBar_ShouldBeConnected {
    //then
    XCTAssertNotNil(sut.dragBar);
}

- (void)testPlayerView_ShouldBeSet {
    //when
    sut.player = [PlayerView new];

    //then
    XCTAssertNotNil(sut.player);
}


@end
