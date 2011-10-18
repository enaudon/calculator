
+-----------------------------------------+
| * * * * * * * * * * * * * * * * * * * * | 
| * * * * *  Calculator README  * * * * * |
| * * * * * * * * * * * * * * * * * * * * |
+-----------------------------------------+


GENERAL INFORMATION
* Program Name : Calculator
* Version      : v4.0
* Institution  : Bowdoin College
* Developer    : Enrique S. Naudon
* Date Created : 09/13/11
* Last Updated : 10/17/11

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
- 2D graphing capabilities

KNOWN BUGS/ISSUES
- During expression-building, when a digit is pressed, it is shown alone on the
  display until the next operation is pressed.
- Graph title remains previous expression even after clear button is pressed.

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
v3.1 - Evaluate button is now disable when an expression is not being built.
       Improved display management and the implimentation of several functions.
v3.2 - Added navigation controller and graphing button.  Graph button simply
       pushes a GraphViewController and empty graph onto the navigation
       controller.
v3.3 - Graph now displays axes without any tick marks or numbers.
v3.4 - Added the framework for graphing functionality.  Discovered bug: while
       the functions for graphing are there, the GraphViewController seems to
       try drawing on a GraphView that it is not displaying.  Fail.
v3.5 - Graphing functionality added.  However, adjustments have not been made
       to account for the display's origin being in the upper-left corner.
       Fixed aforementioned graphing bug.
v3.6 - Graph now displays axes with tick marks and number based on scale.  Wow,
       sick.
v3.7 - Added zooming functionality, however zoom value is hardcoded.
v3.8 - Added slider to control zooming functionality.
v3.9 - Added dot-drawing functionality and a switch to switch between dot-draw
       and line-draw modes.
v4.0 - Reworked the GUI, added titles to navigation bars and updated
       documentation.

ACKNOWLEDGEMENTS
     Thanks to EJ Googins for pointing out encapsulation and access issues with
regard to the display and its associated property, in addition to errors in
several methods that required iterating through the expressions elements in
v3.0's source code.  Also, EJ was showed me how to add a titles to my
navigation bar.
     Thanks to Hartley Brodey for showing me how to change the background color of my UIButtons.

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
* Updated : 10/17/11
