% Read model information from input file
[FE_model] = FE_input('input.txt');

% Initialize equation numbering for subsequent partition 
[FE_model] = FE_initialize(FE_model);

% Run finite element analysis
[UUR, PUR, FE_model, GRAD_THETA] = FE_analysis(FE_model);

% Write unreduced displacement and load vectors to output file
FE_output(UUR, PUR, 'output.txt');

