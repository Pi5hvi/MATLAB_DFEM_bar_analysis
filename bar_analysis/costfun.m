function [f] = costfun(PARAM_VAL)
global FE_model

FE_model.PARAM_VAL=PARAM_VAL;
[FE_model] = FE_update(FE_model);
[~, ~, FE_model, GRAD_THETA] = FE_analysis(FE_model);

f = FE_model.THETA(1);
%gradf = GRAD_THETA(:, 1);

end