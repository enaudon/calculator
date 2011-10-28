/*
 *Program Name : Calculator
 *Version      : 4.0
 *Institution  : Bowdoin College
 *Developer    : Enrique Naudon
 *Date Created : 09/13/11
 *Last Updated : 10/28/11
 *Description  : This is an Objective-C calculator app written for the 3rd
 *               generation iPhone's iOS platform.  Upon execution, 
 *               Calculator presents the user with a fairly standard
 *               calculator interface.  The user interacts with Calculator
 *               by pressing the various digit and operation buttons as one
 *               would on a normal calculator.   
 */

//  main.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
