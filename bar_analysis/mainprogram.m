% MAIN PROGRAM
 function [] = mainprogram()

global FE_model
global PARAM_VAL
global PARAM_VAL_OLD
global GRAD_THETA
global itercounter
global iterhistory

PARAM_VAL_OLD = []; % initialize variables
GRAD_THETA = [];

[FE_model] = FE_input('input.txt');
[FE_model] = FE_initialize(FE_model);

iterhistory=FE_model.PARAM_VAL;
itercounter=1;

PARAM_LOW = zeros(1,FE_model.N_PARAM);
for i=1:FE_model.N_PARAM
    PARAM_LOW(1,i)=0.01;
end
PARAM_UPP = zeros(1,FE_model.N_PARAM);
for i=1:FE_model.N_PARAM
    PARAM_UPP(1,i)=5-(i/2);
end
options = optimset('GradObj', 'off', 'GradConstr', 'off');
PARAM_VAL=FE_model.PARAM_VAL;

%[PARAM_VAL] = fmincon(@costfun, PARAM_VAL, [], [], [], [], PARAM_LOW, PARAM_UPP, ...
%@nlconfun, options);

[PARAM_VAL] = ga(@costfun,5, [], [], [], [], PARAM_LOW, PARAM_UPP, ...
@nlconfun, options);

iterhistory
i=1:(itercounter-1);
hold on
plot(i,iterhistory(:,1))
plot(i,iterhistory(:,2))
plot(i,iterhistory(:,3))
plot(i,iterhistory(:,4))
plot(i,iterhistory(:,5))
legend Element-1 Element-2 Element-3 Element-4 Element-5
xlabel 'Iteration Number'
ylabel 'Element Moduli'

 end