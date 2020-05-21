function [FE_model] = FE_input(input_file_name)
%
% This module reads the input file with element and boundary conditions
% information to run the analysis for the springs system
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.1 in the book

% Instead of using the usual file reading functions fopen/fscan/fclose, use
% the 'csvread' function in Matlab to read the whole input file at once.
% This is acceptable for small models (because the entire file will be in a
% single variable in memory).
%
input_text = csvread(input_file_name);

FE_model.N_NODE = input_text(1,1); % # of nodes
FE_model.N_ELEM = input_text(1,2); % # of elements
FE_model.N_FORCE = input_text(1,3); % # of prescribed forces
FE_model.N_PRE_DISP = input_text(1,4); % # of prescribed displacements

%COORDS addition
FE_model.COORDS = zeros(1,FE_model.N_NODE);
for i= 1:FE_model.N_NODE
    FE_model.COORDS(i)=input_text(1+i,1);
end
%Initialize arrays of correct size with zero values
FE_model.nodes_per_elem = 2; % Each spring has two nodes
FE_model.n_mat_param = 1;    % Each spring has one material parameter--its spring constant

FE_model.ELEM_NODE = zeros(FE_model.nodes_per_elem, FE_model.N_ELEM);
FE_model.ELEM_STIFF = zeros(FE_model.n_mat_param, FE_model.N_ELEM);
FE_model.FORCE_NODE = zeros(1, FE_model.N_FORCE);
FE_model.FORCE_VALUE = zeros(1, FE_model.N_FORCE);
FE_model.DISP_NODE = zeros(1, FE_model.N_PRE_DISP);
FE_model.DISP_VALUE = zeros(1, FE_model.N_PRE_DISP);

row_count = 2+FE_model.N_NODE;

%Read element data
col_start = 1;  % Element node data section starts at row 2, col 1
col_end = FE_model.nodes_per_elem;
FE_model.ELEM_NODE(1:FE_model.nodes_per_elem, 1:FE_model.N_ELEM) = ...
    input_text(row_count:row_count+FE_model.N_ELEM-1, col_start:col_end)';
           
col_start = FE_model.nodes_per_elem + 1;  % Spring stiffnesses section 
                                 % starts at row 2, col nodes_per_elem + 1
col_end = col_start + FE_model.n_mat_param - 1;
FE_model.ELEM_STIFF(1:FE_model.n_mat_param, 1:FE_model.N_ELEM) = ...
    input_text(row_count:row_count+FE_model.N_ELEM-1, col_start:col_end)';
           
%Read ELEM_LOAD data
%FE_model.FORCE_NODE(1, 1:FE_model.N_FORCE) = ...

FE_model.ELEM_LOAD(1, 1:FE_model.N_ELEM) = ...
    input_text(row_count:row_count+FE_model.N_ELEM-1, 4); % Force magnitude is in column 4

row_count = row_count + FE_model.N_ELEM;

%Read Conc load data
if FE_model.N_FORCE ~= 0
FE_model.FORCE_NODE(1, 1:FE_model.N_FORCE) = ...
    input_text(row_count:row_count+FE_model.N_FORCE-1, 1); % Node on which 
                                                         % force is applied is in column 1
FE_model.FORCE_VALUE(1, 1:FE_model.N_FORCE) = ...
    input_text(row_count:row_count+FE_model.N_FORCE-1, 2); % Force magnitude is in column 2
   % input_text(row_count:row_count+FE_model.N_FORCE-1, 1); % Node on which 
                                                         % force is applied is in column 1
end

row_count = row_count + FE_model.N_FORCE;

%Read prescribed displacement data
FE_model.DISP_NODE(1, 1:FE_model.N_PRE_DISP) = ...
    input_text(row_count:row_count+FE_model.N_PRE_DISP-1, 1); % Node on which 
                                                            % displacement is prescribed is in column 1
FE_model.DISP_VALUE(1, 1:FE_model.N_PRE_DISP) = ...
    input_text(row_count:row_count+FE_model.N_PRE_DISP-1, 2); % Magnitude of prescribed displacement
                                                            % is in column
                                                            % 2
row_count = row_count + FE_model.N_PRE_DISP;
                                                            
FE_model.N_PARAM = input_text(row_count);
row_count = row_count+1;
for i=1:FE_model.N_PARAM
    FE_model.PARAM_TYPE(i) = input_text (row_count+i-1,1);
    FE_model.PARAM_ENT_NUM(i) = input_text (row_count+i-1,2);
    FE_model.PARAM_VAL(i) = input_text (row_count+i-1,3);
end

