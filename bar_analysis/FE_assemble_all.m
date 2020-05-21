function [Kpp, Kpf, Kff, Kfp, PP, PF, UP] = FE_assemble_all(FE_model)
%
% Assemble vector of prescribed displacements, vector of
% applied forces, and partitioned global stiffness matrix.
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.7 in the book

% Initialize vectors/arrays
UP = zeros(1, FE_model.N_PRE_DISP);
PP=0;
PF = zeros(FE_model.N_NODE-FE_model.N_PRE_DISP, 1);
Kpp = zeros(FE_model.N_PRE_DISP, FE_model.N_PRE_DISP);
Kpf = zeros(FE_model.N_PRE_DISP, FE_model.N_NODE-FE_model.N_PRE_DISP);
Kfp = zeros(FE_model.N_NODE-FE_model.N_PRE_DISP, FE_model.N_PRE_DISP);
Kff = zeros(FE_model.N_NODE-FE_model.N_PRE_DISP, FE_model.N_NODE-FE_model.N_PRE_DISP);

% Assemble vector of prescribed displacements
[UP] = FE_disp_assemble(FE_model, UP);

% Assemble vector of applied forces
[PF] = FE_force_assemble(FE_model, PF);

% ...and finally assemble partitioned global stiffness matrix
for ielem = 1:FE_model.N_ELEM
    [Kel,Pel] = FE_element(ielem, FE_model.ELEM_STIFF, FE_model.COORDS, FE_model.ELEM_LOAD);  % Get the element stiffness matrix
    % ...and now add it to the global stiffness matrix
    [Kpp, Kpf, Kfp, Kff, PP, PF] = FE_element_to_global_stiffness(ielem, Kel, ...
                                    Pel, FE_model, Kpp, Kpf, Kfp, Kff, PP, PF); 
end
