+-----------------------------------------+
| * * * * * * * * * * * * * * * * * * * * | 
| * * * * *  Calculator README  * * * * * |
| * * * * * * * * * * * * * * * * * * * * |
+-----------------------------------------+


GENERAL INFORMATION
* Program Name : Calculator
* Version      : v3.0
* Institution  : Bowdoin College
* Developer    : Enrique S. Naudon
* Date Created : 09/13/11
* Last Updated : 09/28/11

DESCRIPTION
     This is an Objective-C calculator app written for the 3rd generation
iPhone's iOS platform.  Upon execution, Calculator presents the user with a
fairly standard calculator interface.  The user interacts with Calculator by
pressing the various digit and operation buttons as one would on a normal
calculator.  

FEATURES
- Standard calculator functions (addition, subtraction, multiplication and
  division)
- Standard trig functions (sine, cosine and tangent)
- Memory functions (store, recall, memory addition and memory subtraction)
- Advanced functions (square, squareroot, negation and inversion)
- Expression building and evaluation functionality
- Support for variables in expressions

KNOWN BUGS/ISSUES
- During expression-building, when a digit is pressed, it is shown alone on the
  display until the next operation is pressed.
- Variable values are hardcoded as their ASCII/unicode encodings.

VERSION HISTORY
v1.0 - Five function (+, -, *, / and sqrt) calculator.  Only supported integer
       inputs.  Source code lacks comments.
v1.1 - Square function added.  Comments added to source code.  "operand" and 
       "waitingOperand" variable names changed.
v1.2 - Support for inversion, negation and standard trig functions (sin, cos
       and tan) added.  Discovered bug: respecifying the operation after one
       operand has been input executes the original operation.
v1.3 - Buttons resized to make room for functions to be added in v1.5 and v1.6.
       Fixed doubly-specified-operation bug.
v1.4 - Variable "operand1" made into a property.
v1.5 - Basic memory functions introduced: store and recall buttons added.
v1.6 - Basic memory operations introduced: mem+ and mem- buttons added.
       Discovered bug: inputting multiple decimal points is not prevented;
       only the digits before the second decimal point are considered.
v1.7 - Implementation of memory functionality improved: all memory buttons
       linked to a single function; store and recall FUNCTIONS removed from
       source code, but the FUNCTIONALITY remains.
v1.8 - Fixed minor issues in source code.  Fixed multiple-decimal-points bug.
v2.0 - Improved documentation (including adding this README).
v2.1 - Implemented destructors for CalculatorViewController and CalculatorBrain
       objects.
v2.2 - Variables "waitingOperation" and  "display" implemented as a private
       properties.
v2.3 - Improved implementation of memory operations.
v2.4 - Implemented support for variables.  Variable values are hardcoded as
       their ASCII encodings.
v2.5 - Implemented "variablesInExpression" fuction.  Discovered bug: memory
       leak in "variablesInExpression" function (return set not properly
       released).
v2.6 - Implemented variable enumeration functionality for expressions.
v2.7 - Implemented expression-to-string conversion functionality.
v2.8 - Expressions are shown on the display as they are being implemented.
v2.9 - Implemented property list/expression conversion functionality.
v3.0 - Implemented error reporting for division by zero.  Updated documentation
       (ie. this README).

CONTACT INFORMATION
Enrique S. Naudon
Bowdoin College
504 Smith Union
Brunswick, ME 04011
(917) 907-4028 (cell)
enaudon@bowdoin.edu

README's README
* Author  : Enrique S. Naudon
* Created : 09/19/11
* Updated : 09/28/11
