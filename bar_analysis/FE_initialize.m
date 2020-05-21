function [FE_model] = FE_initialize(FE_model)
%
% This module initializes equation numbering (which is the way to partition
% the stiffness matrix in free-free, free-prescribed, prescribed-free, and
% prescribed-prescribed parts).
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.2 in the book

FE_model.EQ_NUM = zeros(1, FE_model.N_NODE);

for inode=1:FE_model.N_PRE_DISP
    node_id = FE_model.DISP_NODE(inode);
    FE_model.EQ_NUM(node_id) = -inode;  % We 'mark' a node with a prescribed 
                                      % displacement by giving it a
                                      % negative equation number
end
%...and then we number the remaining free nodes (called Degrees of Freedom)
FE_model.N_DOF = 0;
for inode=1:FE_model.N_NODE
    if FE_model.EQ_NUM(inode) == 0 % I.e. if it has not been marked as prescribed
        FE_model.N_DOF = FE_model.N_DOF + 1;
        FE_model.EQ_NUM(inode) = FE_model.N_DOF;
    end
end

        