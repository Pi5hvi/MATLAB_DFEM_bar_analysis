function [UUR, PUR, FE_model, GRAD_THETA] = FE_analysis(FE_model)
%
% Perform the finite element analysis and get unreduced displacement and
% load vectors.
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.9 in the book

[Kpp, Kpf, Kff, Kfp, PP, PF, UP] = FE_assemble_all(FE_model);

[UUR, PUR] = FE_solve(FE_model, Kpp, Kpf, Kfp, Kff, PP, PF, UP); 

% Ain't that easy?

[FE_model,GRAD_THETA] = FE_adjoint(FE_model,UUR,PUR,Kff,Kfp);