function [Kpp, Kpf, Kfp, Kff, PP, PF] = FE_element_to_global_stiffness(ielem, Kel, ...
                                    Pel, FE_model, Kpp, Kpf, Kfp, Kff, PP, PF)                                
%
% Given an element ielem and its stiffness matrix Kel, add the
% components of the element stiffness matrix to the right locations in the
% global stiffness matrix.
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.4 in the book

for i = 1:FE_model.nodes_per_elem                        % Node i (local)
    inode = FE_model.ELEM_NODE(i, ielem);      % Node inumber (global)
    row = FE_model.EQ_NUM(inode);  
    for j = 1:FE_model.nodes_per_elem                    % Node j (local)
        jnode = FE_model.ELEM_NODE(j, ielem);  % Node j number (global)
        col = FE_model.EQ_NUM(jnode);
        if row > 0      % If row corresponds to free DOF...
            if col > 0    % and if col corresponds to free DOF
                Kff(row,col) = Kff(row,col) + Kel(i,j);
                if row==col
                    PF(row,1) = PF(row,1) + Pel(i);
                end
            else          % if column corresponds to prescribed DOF
                Kfp(row,-col) = Kfp(row,-col) + Kel(i,j);
            end
        else             % If row corresponds to prescribed DOF...
            if col > 0     % and if col corresponds to free DOF
                Kpf(-row,col) = Kpf(-row,col) + Kel(i,j);
            else           % if col corresponds to prescribed DOF
                Kpp(-row,-col) = Kpp(-row,-col) + Kel(i,j);
                PP(-row,-col) = PP(-row,-col) + Pel(i,j);
            end
        end
    end
end

            
    