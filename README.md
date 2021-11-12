# Assignment 3: The End of the Beginning
## Introduction
As we discussed in class, there are very few examples of true logic/declarative programming languages and Prolog is by far the most popular/common. In Assignment 3, you will get a chance to use Prolog to build a predicate that solves a combinatorial math problem. We won't jump right in to solving the final problem, though. First, we will define several helper predicates that will make it easier for you to build a solution to the ultimate challenge. Let's get started!

At the finish line of this assignment is the definition of a predicate, which we will call combo, that determines whether a combination of mathematical operations can be applied to a list of numbers so that the result is a specific value.

For example, can you write an equation for the number 5 using every number from the list 1, 3, 7 in that order and only the mathematical operations plus and minus?

`1 - 3 + 7 = 5`

The mathematical expressions that we test will be strictly evaluated left-to-right and will **not** account for precedence. Therefore, for example,

`1 + 3 * 7 = (1 + 3) * 7 = 28`

and not 22. Let's look at some other examples! Can we write an equation for the number 5 using every number from the list 1, 2, 3, 4, 5 in that order using the mathematical operations add, subtract, multiply and divide?

```
1 + 2 + 3 + 4 - 5 = 5
1 + 2 - 3 * 4 + 5 = 5
1 + 2 - 3 / 4 + 5 = 5
1 - 2 * 3 + 4 * 5 = 5
1 * 2 + 3 - 4 * 5 = 5
1 * 2 * 3 + 4 - 5 = 5
```

In order to make our programming task easier, we will write several predicates. The first predicate that we will write is named apply/4. apply/4 performs an operation on two operands and generates the result. The first term of the predicate function is an atom designating the operation to apply: add, subtract, multiply, divide. The second and third terms will be operands to the operation. The final term will be the result. This predicate will never be invoked to generate values. This crucial detail makes our implementation easier. A query like

?- apply(add, 5, 4, C).
C = 9.
No surprises!

The second predicate that we will write is named apply_lr/3. apply_lr/3 applies a list of operations to a list of operands. The first term is a list of operations. The second term is a list of operands. The list of operands is guaranteed to always be length 1 greater than the length of the list of operations. The final term is the result of applying (infix) each operator to the list of operands. Again, this predicate will never be invoked to generate values. A query like

?- apply_lr([add, subtract], [5, 4, 9], Result).
Result = 0 ;
In other words, the effect of apply_lr in this case is: (5 + 4) - 9. The semantics of apply_lr matches the description above: all operations are evaluated left-to-right and do not take into account precedence. As another example,

?- apply_lr([add, divide], [5, 4, 9], Result).
Result = 1 ;
and not 5.444.

The third, and final, helper predicate that we will define is the all_lists/3 predicate. all_lists/3 generates lists of a certain length with all the combinations of a given set of atoms. The first term is the length of the lists to generate. The second term is a list of atoms. The third term is a list of length given by the first term whose elements are a permutation of the atoms in the second term. I know. This definitely calls for an example:

?- allLists(3, [add, subtract], Result).
Result = [add, add, add] ;
Result = [add, add, subtract] ;
Result = [add, subtract, add] ;
Result = [add, subtract, subtract] ;
Result = [subtract, add, add] ;
Result = [subtract, add, subtract] ;
Result = [subtract, subtract, add] ;
Result = [subtract, subtract, subtract].
With those three helper predicates, it is possible to write the combo/3 predicate.

?- combo([subtract, add], [1,3,7], 5).
true ;
or

?- combo(Ops, [1,3,7], 5).
Ops = [subtract, add] ;
Pretty cool!

Programming Task
Your task is to implement the apply/4, apply_lr/3, all_lists/3 and combo/3 predicates. 

apply/4
apply/4 performs an operation on two operands and generates the result. The first term of the predicate function is an atom designating the operation to apply: add, subtract, multiply, divide. The second and third terms will be operands to the operation. The final term will be the result. This predicate will never be invoked to generate values.

Assumptions:

You may assume that the second and third terms will always be instantiated -- in other words, this predicate will never be used to generate values that, when applied to an operator, yield a certain value.
Recommendations:

Use the is/2 predicate (Links to an external site.).
apply_lr/3
apply_lr/3 applies a list of operations to a list of operands. The first term is a list of operations. The second term is a list of operands. The list of operands is guaranteed to always be length 1 greater than the length of the list of operations. The final term is the result of applying (infix) each operator to the list of operands. Again, this predicate will never be invoked to generate values. A query like

?- apply_lr([add, subtract], [5, 4, 9], Result).
Result = 0 ;
In other words, the effect of apply_lr/3 in this case is: (5 + 4) - 9. The semantics of apply_lr matches the description above: all operations are evaluated left-to-right and do not take into account precedence. As another example,

?- apply_lr([add, divide], [5, 4, 9], Result).
Result = 1 ;
and not 5.444.

Assumptions:

You may assume that the second and third terms will always be instantiated -- in other words, this predicate will never be used to generate lists of operations and operands.
You may assume that the length of the list of operations will always be length 1 less than the list of the operands.
Recommendations:

Do a case analysis.
Define the base case (where the first term contains a single operation and the second term contains exactly two operations) and handle it appropriately.
In the recursive case,
Use apply/4 to perform the operation at the head of the list in the first term on the (two) operands at the head of the list in the second term
Replace the two operands at the head of the list in the second term with the result of that operation
Drop the completed operation from the list in the first term
Invoke apply_lr/3 recursively with the updated lists
all_lists/3
all_lists/3 generates lists of a certain length with all the combinations of a given set of atoms. The first term is the length of the lists to generate. The second term is a list of atoms. The third term is a list of length given by the first term whose elements are a permutation of the atoms in the second term. See above for an example.

Recommendations:

Assuming that you have a number, say 3, you can use the length/2 predicate to instantiate a list of that length with "don't care" (i.e., _) values in each entry: ?- length(X, 3). X = [_, _, _].
Create a helper predicate that fills in a list of "don't care" values with elements from the list in the second term.
The member/2 predicate can instantiate an element from a list: ?- member(H, [1,2,3]). H = 1; H = 2; H = 3.
combo/3
combo/3 determines whether some combinations of operations can be invoked (infix) on a list of operands to generate a value. The first term is a list of operations to apply to the values in the list in the second term. The third term is the mathematical result of apply the operations from the list in the first term to the values in the list in the second term (without changing their order!). The cool thing about combo/3 is that you can use it in multiple ways:

?- combo([add, subtract], [1,2,3], Y).
Y = 0 ;
?- combo(X, [1,2], Y).
X = [add],
Y = 3 ;
X = [subtract],
Y = -1 ;
X = [multiply],
Y = 2 ;
X = [divide],
Y = 0.5 ;
?- combo(X, [1,3,7], 5).
X = [subtract, add] ;
Assumptions:

The second term will always be instantiated. In other words, combo/3 will never be used to generate a list of values that can be applied to a given set of operations to generate a particular value.
add, subtract, multiply and divide are all valid operations.
Operations are performed left-to-right wIth no regard for precedence.
Recommendations:

length/2 can be used to "create" an empty list of a certain length. See above for an example.
is/2 can be used to instantiate a variable that is mathematically related to another variable: ?- Y is 5 + 1. Y = 6.
all_lists/3 can generate all lists of operations.
apply_lr/3 can instantiate the value of applying the generated list of operations to a list of values.
Getting Started
To begin this assignment, make sure that you have a working installation of Prolog:

Linux (Links to an external site.)
Windows
Mac
Tips and Tricks
When I built my solution, I worked slowly and defined each of the predicates in turn. I used the Prolog REPL to load in the code of my implementations and tested each one interactively. The best way to determine whether a Prolog program is working as intended is to run queries and observe their results.

If you are unsure about why Prolog is generating a particular unification, you may find trace/0 (Links to an external site.) to be useful.

For additional information about resources for learning Prolog, check out the External Resources.

Submission Requirement and Grading Rubric
This assignment is worth 100 points. Gradescope support for this assignment is coming soon.

This assignment is due on November 21st at 11:59PM.
