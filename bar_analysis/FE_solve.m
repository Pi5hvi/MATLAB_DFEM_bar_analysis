function [UUR, PUR] = FE_solve(FE_model, Kpp, Kpf, Kfp, Kff, PP, PF, UP)
%
% Solve spring system to obtain unreduced displacement and load vectors,
% given partitioned global stiffness matrix, and vectors of applied forces
% and prescribed displacements.
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.8 in the book

UF = Kff\(PF - Kfp * UP);  % Solve for displacements in free nodes;

UF = UF';  % And make it a row vector again to avoid confusion later
PP = - Kpp * UP' - Kpf * UF' + PP; % ...and then get reaction forces

% That's it!  Now we only need to stitch the unreduced vectors

% Initialize unreduced vectors
UUR = zeros(1, FE_model.N_NODE);
PUR = zeros(1, FE_model.N_NODE);

for inode = 1:FE_model.N_NODE
    row = FE_model.EQ_NUM(inode);
    if row > 0 % I.e. free node
        UUR(inode) = UF(row);
        PUR(inode) = PF(row);
    else       % I.e. prescribed node
        UUR(inode) = UP(-row);
        PUR(inode) = PP(-row);
    end
end
