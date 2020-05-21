function [Kel,Pel] = FE_element(ielem, ELEM_STIFF, COORDS, ELEM_LOAD)
%
% Given the number of an element (spring) and the vector that contains all
% element stiffnesses, this module returns the element stiffness matrix of
% element ielem.
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.3 in the book

k = ELEM_STIFF(ielem);
h = COORDS(ielem+1)-COORDS(ielem);
b = ELEM_LOAD(ielem);
Kel = k/h*[1,-1; -1,1];
Pel=b*h/2*[1;1];