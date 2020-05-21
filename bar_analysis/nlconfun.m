function [g,geq] = nlconfun(PARAM_VAL)
global FE_model
global PARAM_VAL_OLD
global GRAD_THETA
global itercounter
global iterhistory

PARAM_VAL_OLD = PARAM_VAL;
iterhistory(itercounter,:)=PARAM_VAL_OLD;
itercounter=itercounter+1;
[~, ~, FE_model, GRAD_THETA] = FE_analysis(FE_model);

g = FE_model.THETA(2);
%gradgeq = GRAD_THETA(:, 2);
geq=[];
%gradg=[];
end