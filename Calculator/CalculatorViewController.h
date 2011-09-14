//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
    IBOutlet UILabel *display;  //calculator's display
    CalculatorBrain *brain;     //class that performs calculations
    BOOL typing;  //0 = user done specifying operand
                  //1 = user specifying operand
}


//called when digit is pressed.  updates display.
- (IBAction) digitPressed:(UIButton *)sender;

//called when operation is pressed.  performs operation.
- (IBAction) operationPressed:(UIButton *)sender;

@end
