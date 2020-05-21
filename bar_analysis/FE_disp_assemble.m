function [UP] = FE_disp_assemble(FE_model, UP)
%
% Create the vector of prescribed displacements.  Note that UP is
% initialized outside of this module.
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.6 in the book

for idisp=1:FE_model.N_PRE_DISP % Loop over all applied forces
    node = FE_model.DISP_NODE(idisp);   % Number of node where displacement is prescribed
    u = FE_model.DISP_VALUE(idisp);    % Magnitude of corresponding displacement
    row = -FE_model.EQ_NUM(node);      % Recall prescribed displacements have negative rows
    UP(row) = u;
end