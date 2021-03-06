//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.

#import "CalculatorBrain.h"

@implementation CalculatorBrain

@synthesize waitingOperation;
@synthesize operand = operand1, expression = internalExpression;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*--------------------------{ PRIVATE METHODS }--------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Attempts to perform 2-operand operations.
 *If only one operand has been specified, nothing is done.  If an error
 *(division by zero) has occured, 1 is returned; otherwise, an error code
 *of 0 is returned.  Note that the result of the calculation is stored in
 *the operand variable.  This method is private.
 */
- (BOOL) performWaitingOperation
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
  else if ([waitingOperation isEqual:@"÷"])
    if (operand1)
      operand1 = operand2/operand1;
    else return 1;
  
  return 0;
}

/*Adds an object to the expression.
 *This message is private.
 *
 *@param obj the object to be added to the expression
 */
- (void) addToExpression:(id)obj
{
   //initialize internalExpression as needed
   if (!internalExpression)
   internalExpression = [[NSMutableArray alloc] init];
   
   //add operation to expression
   [internalExpression addObject:obj];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*-------------------------{ PROTOCOL  METHODS }-------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Returns the corresponding y-value for the specified x-value.
 *
 *@return the y-value
 */
- (double) solveForYWithX:(double)x
{
  //grab expression
  id expression = internalExpression;
  
  //translate x-value to dictionary
  NSDictionary *vars = [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithDouble:x], @"x",
                        nil];
  
  //solve and returnx
  return [CalculatorBrain evaluateExpression:expression
                               withVariables:vars];
}

/*Returns a string representation of the expression.
 *Appends "y =" to the expression.
 *
 *@return the string representation
 */
- (NSString *) formula
{
  return [NSString stringWithFormat:@"y = %@",
          [CalculatorBrain descriptionOfExpression:self.expression]];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*---------------------------{ CLASS METHODS }---------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Evaluates the specified expression, substituting the specified values for
 *any variables found in the expression.
 *
 *@param expression the expresion to be evaluated
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
      //handle variables
      if([term length] == ([VAR_PREFIX length]+1) &&
         [term characterAtIndex:0] == [VAR_PREFIX characterAtIndex:0])
      {
        //get the key and corresponding value from variable dictionary
        NSString *key = [term substringFromIndex:[VAR_PREFIX length]];
        id value = [variables valueForKey:key];
        
        //make sure the value (element at key) is an NSNumber
        if ([value isKindOfClass:[NSNumber class]]) {
          double operand = [value doubleValue];
          [brain setOperand:operand];
        }
      }
      //handle operations
      else
        [brain performOperation:term];
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
 *@param expression the expresion whose variables are to be enumerated
 *@return           the set of variables in expression
 */
+ (NSSet *)variablesInExpression:(id)expression
{
  //createan NSSet to hold the variables in expression
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
      NSString *var = [term substringFromIndex:[VAR_PREFIX length]];
      
      //add the variable to the set if it isn't already in the set
      if (![varSet member:var])
        [varSet addObject:var];
    }
  }
  
  //return varSet
  return [varSet anyObject] ? varSet : nil;
}

/*Returns an NSString representation of the specified expression.
 *
 *@param expression the expresion to be converted
 *@return           the string representation of the expression
 */
+ (NSString *)descriptionOfExpression:(id)expression
{
  //create an NSString to hold the expression
  NSString *description = [[[NSString alloc] init] autorelease];
  
  for (id term in expression)
  {
    //handle operands
    if ([term isKindOfClass:[NSNumber class]])
      description = [description stringByAppendingFormat:
                     @"%@ ", [term stringValue]];
    
    //handle string elements
    else if ([term isKindOfClass:[NSString class]])
    {
      //handle variables
      if([term length] == ([VAR_PREFIX length]+1) &&
         [term characterAtIndex:0] == [VAR_PREFIX characterAtIndex:0])
      {
        NSString *var = [term substringFromIndex:[VAR_PREFIX length]];
        description = [description stringByAppendingFormat:@"%@ ", var];
      }
      //handle operations
      else
        description = [description stringByAppendingFormat:@"%@ ", term];
    }
  }
  
  //return description
  return [description length] ? description : nil;
}

/*Returns the specified expression as a property list.
 *As expressions are already property lists, an autoreleased copy of the
 *specified expression is returned.  (A copy is returned instead of
 *retaining and returning the original in case the caller needs to work
 *with the expression AND the property list separately.)
 *
 *@param expression the expresion to be converted
 *@return           the property list
 */
+ (id)propertyListForExpression:(id)expression
{
  return [[expression copy] autorelease];
}

/*Returns the specified property list as an expression.
 *As expressions are already property lists, an autoreleased copy of the
 *specified property list is returned.  (A copy is returned instead of
 *retaining and returning the original in case the caller needs to work
 *with the property list AND the expression separately.)
 *
 *@param propertyList the expresion to be converted
 *@return             the expression
 */
+ (id)expressionForPropertyList:(id)propertyList
{
  return [[propertyList copy] autorelease];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*-------------------------{ INSTANCE  METHODS }-------------------------*/
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

/*Attempts to perform the specified operation.
 *If a 2-operand operation is requested, performWaitingOperation is called.
 *The result is returned as an NSString to facilitate returning error
 *messages.
 *
 *@param operation the operation to be performed
 *@return          the result of the calculation
 */
- (NSString *) performOperation:(NSString *)operation
{
  //declare string to hold the result
  NSString *result = DIV_ZERO;
  
  //add the operand to the expression
  [self addToExpression:operation];
  
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
  else if ([operation isEqual:@"1/x"])
    if (operand1)
      operand1 = 1/operand1;
    //yes, this is sloppy, i know.  i'll get to it.
    else
      return [result autorelease];
  
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
  else if ([operation isEqual:@"MS"])
    memory = operand1;
  
  //handle recall
  else if ([operation isEqual:@"MR"])
    operand1 = memory;
  
  //handle memory addition
  else if ([operation isEqual:@"M+"]) {
    operand1 = memory + operand1;
    memory = operand1;
  }
  
  //handle memory subtraction
  else if  ([operation isEqual:@"M-"]) {
    operand1 = memory - operand1;
    memory = operand1;
  }
  
  //handle 2-operand operations
  else {
    if ([self performWaitingOperation])
      return [result autorelease];
    self.waitingOperation = operation;
    operand2 = operand1;
  }
  
  result = [NSString stringWithFormat:@"%g", operand1];
  return result;
}

/*Adds a variable to the expression.
 *
 *@param variable the variable to be added
 */
- (void) setVariableAsOperand:(NSString *)variable
{ 
  //add operand to internalExpression
  NSString *vp = VAR_PREFIX;
  [self addToExpression:[vp stringByAppendingString:variable]];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*------------------------{ GETTERS AND SETTERS }------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*Getter for expression property.
 *A copy is returned to prevent the caller from modifying the contents of
 *the expression.  (Note that expression is associated with the 
 *internalExpression variable.)
 *
 *return a copy of internalExpression
 */
- (id) expression
{
  return [[internalExpression copy] autorelease];
}

/*Setter for operand property.
 *The specified operand is added to the expression.  (Note that operand is
 *associated with the operand1 variable.)
 *
 *@param operand the new value of operand1
 */
- (void) setOperand:(double)operand
{  
  //add operand to internalExpression
  [self addToExpression:[NSNumber numberWithDouble:operand]];
  
  //set operand1 to operand
  operand1 = operand;
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*---------------------------{ OTHER METHODS }---------------------------*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

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
