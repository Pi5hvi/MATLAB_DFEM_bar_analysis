function [PF] = FE_force_assemble(FE_model, PF)
%
% Create the vector of applied loads (the F indicates the fact that these
% loads can only be applied on free degrees-of-freedom.  Note that PF is
% initialized outside of this module.
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.5 in the book

for iload=1:FE_model.N_FORCE % Loop over all applied forces
    node = FE_model.FORCE_NODE(iload);  % Number of node where force is applied
    f = FE_model.FORCE_VALUE(iload);    % Magnitude of corresponding force
    row = FE_model.EQ_NUM(node);     
    if row > 0 % Make sure forces are only added on free nodes
        PF(row) = PF(row) + f;
    end
end
