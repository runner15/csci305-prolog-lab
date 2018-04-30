% Zachariah Fahsi
% CSCI 305 Prolog Lab 2
/* 	
	cd.
	working_directory(X,'Documents/Montana/CSCI305/Lab4_Prolog/').
	consult(royal).
	consult(prolog_lab).
*/

% M is the mother of C if M is the parent of C, and M is female
mother(M,C):- parent(M,C), female(M).
father(F,C):- parent(F,C), male(F).

% H is the spouse of W if H is married to W, or W is married to H
spouse(H,W):- married(H,W).
spouse(H,W):- married(W,H).

% C is the child of P if P is the parent of C
child(C,P):- parent(P,C).
son(S,P):-child(S,P), male(S).
daughter(D,P):-child(D,P), female(D).

% B is the sibling of S provided that M is a mother of B, and M is a mother of S
% and F is a father of B, and F is a father of S, and B and S are different
sibling(B,S):- 
    mother(M,B),
    mother(M,S),
    father(F,B),
    father(F,S),
    B\=S.
brother(B,S):-sibling(B,S), male(B).
sister(S,B):-sibling(S,B), female(S).

% U is the uncle of N provided that M is a brother of P, and P is a parent of N
uncle(U,N):- brother(U,P), parent(P,N).
aunt(A,N):- sister(A,P), parent(P,N).

% M is the grandparent of C provided that M is the parent of N, and N is the parent of C
grandparent(G,C):- parent(G,P), parent(P,C).
grandfather(G,C):- grandparent(G,C), male(G).
grandmother(G,C):- grandparent(G,C), female(G).
grandchild(C,G):- grandparent(G,C).

% A is the ancestor of D provided that A is the parent of C, and C is the ancestor of D
ancestor(A,D):- parent(A,D).
ancestor(A,D):- parent(A,C),ancestor(C,D).

% D is the descendant of A provided that A is an ancestor of D
descendant(D,A):-ancestor(A,D).

% X is older than Y provided that the birth year (Z) of X is lower than the birth year (W) of Y
older(X,Y):- born(X,Z), born(Y,W), Z<W, \+ died(X,_), \+ died(Y,_).
younger(X,Y):- older(Y,X).

% R was a regent when B was born provided that the birth year (C) of B is between 
% the start year (S) and end year (E) of the regent R
regentWhenBorn(R,B):- born(B,C), reigned(R,S,E), S<C, C<E.

% C is a cousin of D provided that P is a parent of C, Q is a parent of D, 
% P and Q are siblings, and C and D are different
cousin(C,D):- parent(C,P),parent(D,Q),sibling(P,Q), C\=D.
