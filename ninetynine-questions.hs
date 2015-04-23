__NOTOC__

This is part of [[H-99:_Ninety-Nine_Haskell_Problems|Ninety-Nine Haskell Problems]], based on [https://sites.google.com/site/prologsite/prolog-problems  Ninety-Nine Prolog Problems] and [http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html Ninety-Nine Lisp Problems].

== Problem 1 ==

(*) Find the last element of a list.

(Note that the Lisp transcription of this problem is incorrect.)

Example in Haskell:

<haskell>
Prelude> myLast [1,2,3,4]
4
Prelude> myLast ['x','y','z']
'z'
</haskell>



[[99 questions/Solutions/1 | Solutions]]


== Problem 2 ==

(*) Find the last but one element of a list.

(Note that the Lisp transcription of this problem is incorrect.)

Example in Haskell:

<haskell>
Prelude> myButLast [1,2,3,4]
3
Prelude> myButLast ['a'..'z']
'y'
</haskell>

[[99 questions/Solutions/2 | Solutions]]


== Problem 3 ==

(*) Find the K'th element of a list. The first element in the list is number 1.

Example:

<pre>
* (element-at '(a b c d e) 3)
c
</pre>

Example in Haskell:

<haskell>
Prelude> elementAt [1,2,3] 2
2
Prelude> elementAt "haskell" 5
'e'
</haskell>

[[99 questions/Solutions/3 | Solutions]]


== Problem 4 ==

(*) Find the number of elements of a list.

Example in Haskell:

<haskell>
Prelude> myLength [123, 456, 789]
3
Prelude> myLength "Hello, world!"
13
</haskell>

[[99 questions/Solutions/4 | Solutions]]


== Problem 5 ==

(*) Reverse a list.

Example in Haskell:

<haskell>
Prelude> myReverse "A man, a plan, a canal, panama!"
"!amanap ,lanac a ,nalp a ,nam A"
Prelude> myReverse [1,2,3,4]
[4,3,2,1]
</haskell>

[[99 questions/Solutions/5 | Solutions]]


== Problem 6 ==

(*) Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x).

Example in Haskell:

<haskell>
*Main> isPalindrome [1,2,3]
False
*Main> isPalindrome "madamimadam"
True
*Main> isPalindrome [1,2,4,8,16,8,4,2,1]
True
</haskell>

[[99 questions/Solutions/6 | Solutions]]


== Problem 7 ==

(**) Flatten a nested list structure.

Transform a list, possibly holding lists as elements into a `flat' list by replacing each list with its elements (recursively).

Example:

<pre>
* (my-flatten '(a (b (c d) e)))
(A B C D E)
</pre>

Example in Haskell:

We have to define a new data type, because lists in Haskell are homogeneous. 
<haskell>
 data NestedList a = Elem a | List [NestedList a]
</haskell>

<haskell>
*Main> flatten (Elem 5)
[5]
*Main> flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])
[1,2,3,4,5]
*Main> flatten (List [])
[]
</haskell>



[[99 questions/Solutions/7 | Solutions]]

== Problem 8 ==

(**) Eliminate consecutive duplicates of list elements.

If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.

Example:

<pre>
* (compress '(a a a a b c c a a d e e e e))
(A B C A D E)
</pre>

Example in Haskell:

<haskell>
> compress "aaaabccaadeeee"
"abcade"
</haskell>

[[99 questions/Solutions/8 | Solutions]]

== Problem 9 ==

(**) Pack consecutive duplicates of list elements into sublists.
If a list contains repeated elements they should be placed in separate sublists.

Example:

<pre>
* (pack '(a a a a b c c a a d e e e e))
((A A A A) (B) (C C) (A A) (D) (E E E E))
</pre>

Example in Haskell:

<haskell>
*Main> pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 
             'a', 'd', 'e', 'e', 'e', 'e']
["aaaa","b","cc","aa","d","eeee"]
</haskell>

[[99 questions/Solutions/9 | Solutions]]

== Problem 10 ==

(*) Run-length encoding of a list.
Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.

Example:
<pre>
* (encode '(a a a a b c c a a d e e e e))
((4 A) (1 B) (2 C) (2 A) (1 D)(4 E))
</pre>

Example in Haskell:
<haskell>
encode "aaaabccaadeeee"
[(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]
</haskell>

[[99 questions/Solutions/10 | Solutions]]


[[Category:Tutorials]]

