//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import "CalculatorBrain.h"

#define VAR_PREFIX @"$"

@implementation CalculatorBrain

@synthesize waitingOperation;
@synthesize operand = operand1, expression = internalExpression;

//-----------------------------
/*ASSIGNMENT 3 STUFF FOLLOWS*/
//-----------------------------

+ (NSString *)descriptionOfExpression:(id)expression
{
  //create a brain to perform instance methods and an NSString to hold the
  //the expression
  CalculatorBrain *brain = [[CalculatorBrain alloc] init];
  NSString *description = [[[NSString alloc] init] autorelease];
  
  for (id term in expression)
  {
    //handle operands
    if ([term isKindOfClass:[NSNumber class]])
      description = [description stringByAppendingFormat:
                    @"%s ", [term stringValue]];
    
    //handle string elements
    else if ([term isKindOfClass:[NSString class]])
    {
      //handle operations
      if ([term length] == 1)
        description = [description stringByAppendingFormat:@"%@ ", term];
      
      //handle variables
      else if([term length] == ([VAR_PREFIX length]+1) &&
              [term characterAtIndex:0] == [VAR_PREFIX characterAtIndex:0])
      {
        description = [description stringByAppendingFormat:@"%c ",
                         [term characterAtIndex:[VAR_PREFIX length]]];
      }
    }
  }
  
  //release brain, and return varSet
  [brain release];
  return [description length] ? description : nil;
}

//-----------------------------


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*----------------------------{CLASS METHODS}----------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


/*Evaluates the specified expression, substituting the specified values for
 *any variables found in the expression.
 *
 *return the result of the expression
 */
+ (double) evaluateExpression:(id)expression
                withVariables:(NSDictionary *)variables
{
  //create a brain to perform instance methods and a double to hold the
  //result of the evaluated expression
  CalculatorBrain *brain = [[CalculatorBrain alloc] init];
  double result;
  
  for (id term in expression)
  {
    //handle operands
    if ([term isKindOfClass:[NSNumber class]])
      [brain setOperand:[term doubleValue]];
    
    //handle string elements
    else if ([term isKindOfClass:[NSString class]])
    {
      //handle operations
      if ([term length] == 1)
        [brain performOperation:term];
      
      //handle variables
      else if([term length] == ([VAR_PREFIX length]+1) &&
              [term characterAtIndex:0] == [VAR_PREFIX characterAtIndex:0])
      {
        //get the key and corresponding value from variable dictionary
        NSString *key = [NSString stringWithFormat:@"%c",
                         [term characterAtIndex:[VAR_PREFIX length]]];
        id value = [variables valueForKey:key];
        
        //make sure the value (element at key) is an NSNumber
        if ([value isKindOfClass:[NSNumber class]]) {
          double operand = [value doubleValue];
          [brain setOperand:operand];
        }
      }
    }
  }
  
  //release brain and return result
  result = brain.operand;
  [brain release];
  return result;
}

/*Returns the set of variables that appear in the specified expression.
 *The set contains each variable only once, regardless of the number of
 *times that it appears in the expression.
 *
 *@return the set of variables in expression
 */
+ (NSSet *)variablesInExpression:(id)expression
{
  //create a brain to perform instance methods and an NSSet to hold the
  //variables in expression
  CalculatorBrain *brain = [[CalculatorBrain alloc] init];
  NSMutableSet *varSet = [[[NSMutableSet alloc] init] autorelease];
  
  for (id term in expression)
  {
    //make sure the term is a variable
    //(as opposed to an operand or operation)
    if ([term isKindOfClass:[NSString class]]    &&
        [term length] == ([VAR_PREFIX length]+1) &&
        [term characterAtIndex:0] == [VAR_PREFIX characterAtIndex:0])
    {
      //grab the variable
      NSString *var = [NSString stringWithFormat:@"%c",
                       [term characterAtIndex:[VAR_PREFIX length]]];
      
      //add the variable to the set if it isn't already in the set
      if (![varSet member:var])
        [varSet addObject:var];
    }
  }
  
  //release brain, and return varSet
  [brain release];
  return [varSet anyObject] ? varSet : nil;
}




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*--------------------------{INSTANCE  METHODS}--------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


/*Clears instance variables.
 */
- (void) clear
{
  operand1 = 0;
  operand2 = 0;
  memory   = 0;
  self.waitingOperation = nil;
  [internalExpression removeAllObjects];
}

/*Attempts to perform 2-operand operations.
 *If only one operand has been specified, nothing is done. Also, note that
 *the result of the calculation is stored in the operand variable. This
 *method is private.
 */
- (void) performWaitingOperation
{
  //handle addition
  if ([waitingOperation isEqual:@"+"])
      operand1 = operand2 + operand1;
    
  //handle subtraction
  else if ([waitingOperation isEqual:@"-"])
    operand1 = operand2 - operand1;
    
  //handle multiplication
  else if ([waitingOperation isEqual:@"×"])
    operand1 = operand2*operand1;
    
  //handle division
  //note: fail silently for division by zero
  //(fix that)
  else if ([waitingOperation isEqual:@"÷"])
    if (operand1)
      operand1 = operand2/operand1;
}

/*Attempts to perform the specified operation.
 *If a 2-operand operation is requested, performWaitingOperation is called.
 *
 *@param operation the operation to be performed
 *@return          the result of the calculation
 */
- (double) performOperation:(NSString *)operation
{
  //initialize internalExpression as needed
  if (!internalExpression)
    internalExpression = [[NSMutableArray alloc] init];
  
  //add operation to internalExpression
  [internalExpression addObject:operation];
  
  //handle square root
  if ([operation isEqual:@"√x"])
    operand1 = sqrt(operand1);
  
  //handle square
  else if ([operation isEqual:@"x²"])
    operand1 = pow(operand1, 2);
  
  //handle negation
  //NOTE: this is not implemented yet!
  else if ([operation isEqual:@"(-)"])
    operand1 = - operand1;
  
  //handle inversion
  //note: fail silently for division by zero
  //(fix that)
  else if ([operation isEqual:@"1/x"])
    if (operand1)
      operand1 = 1/operand1;
    //yes, this is sloppy, i know.  i'll get to it.
    else {}
  
  //handle sine
  else if ([operation isEqual:@"sin"])
    operand1 = sin(operand1);
  
  //handle cosine
  else if ([operation isEqual:@"cos"])
    operand1 = cos(operand1);
  
  //handle tangent
  else if ([operation isEqual:@"tan"])
    operand1 = tan(operand1);
  
  //handle storage
  else if ([operation isEqual:@"Str"])
    memory = operand1;
  
  //handle recall
  else if ([operation isEqual:@"Rcl"])
    operand1 = memory;
  
  //handle addition
  else if ([operation isEqual:@"M+"]) {
    operand1 = memory + operand1;
    memory = operand1;
  }
  
  //handle subtraction
  else if  ([operation isEqual:@"M-"]) {
    operand1 = memory - operand1;
    memory = operand1;
  }
  
  //handle 2-operand operations
  else {
    [self performWaitingOperation];
    self.waitingOperation = operation;
    operand2 = operand1;
  }
  
  return operand1;
}

/*Adds a variable to the expression.
 *
 *@param variable the variable to be added
 */
- (void) setVariableAsOperand:(NSString *)variable;
{
  //initialize internalExpression as needed
  if (!internalExpression)
    internalExpression = [[NSMutableArray alloc] init];
  
  //add operand to internalExpression
  NSString *vp = VAR_PREFIX;
  [internalExpression addObject:[vp stringByAppendingString:variable]];
}




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*-----------------{GETTERS, SETTERS AND OTHER  METHODS}-----------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


/*Getter for expression property.
 *(Note that expression is associated with the internalExpression
 *variable.)
 *
 *return a copy of internalExpression
 */
- (id) expression
{
  return [[internalExpression copy] autorelease];
}

/*Setter for operand property.
 *(Note that operand is associated with the operand1
 *variable.)
 *
 *@param operand the new value of operand1
 */
- (void) setOperand:(double)operand
{
  //initialize internalExpression as needed
  if (!internalExpression)
    internalExpression = [[NSMutableArray alloc] init];
  
  //add operand to internalExpression
  [internalExpression addObject:[NSNumber numberWithDouble:operand]];
  
  //set operand1 to operand
  operand1 = operand;
}

/*Destructor.
 */
- (void) dealloc
{
  //release instance variables
  [waitingOperation release];
  [internalExpression release];
  
  //call super-class' destructor
  [super dealloc];
}

@end
