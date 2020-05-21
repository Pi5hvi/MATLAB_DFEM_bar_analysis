function FE_output(UUR, PUR, output_file_name)
%
% Write unreduced displacement and load vectors to ASCII file.
%
% Based on class notes from Prof. Daniel Tortorelli at UIUC
% Modified for Design with the Finite Element Method Class by Julian Norato
% February, 2015
% 
% This is a Matlab implementation of Algorithm 3.10 in the book

save(output_file_name,'UUR','PUR','-ascii');
