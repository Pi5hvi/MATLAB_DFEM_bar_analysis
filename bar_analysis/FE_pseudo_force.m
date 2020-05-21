function [PSEUDO_P,PSEUDO_F,D_UP,D_PF,FE_model] = FE_pseudo_force(FE_model,UUR)
PSEUDO_F=zeros(FE_model.N_DOF,FE_model.N_PARAM);
PSEUDO_P=zeros(FE_model.N_PRE_DISP,FE_model.N_PARAM);
D_UP=zeros(FE_model.N_PRE_DISP,FE_model.N_PARAM);
D_PF=zeros(FE_model.N_DOF,FE_model.N_PARAM);
for iparam = 1:FE_model.N_PARAM
ENTITY_TYPE = FE_model.PARAM_TYPE(iparam);
ENTITY_NUM = FE_model.PARAM_ENT_NUM(iparam);
if ENTITY_TYPE == 1 %Differentiate wrt a spring stiffness
I_ELEM = ENTITY_NUM;
%Compure pseudo force
PSEUDO_EL=[1,-1;-1,1]*[UUR(FE_model.ELEM_NODE(1,I_ELEM));UUR(FE_model.ELEM_NODE(2,I_ELEM))];
if ismember(FE_model.ELEM_NODE(1,I_ELEM), FE_model.DISP_NODE(:))
    %the first node is prescribed
    PSEUDO_P(-FE_model.EQ_NUM(FE_model.ELEM_NODE(1,I_ELEM)),iparam)=PSEUDO_EL(1);
else
    PSEUDO_F(FE_model.EQ_NUM(FE_model.ELEM_NODE(1,I_ELEM)),iparam)=PSEUDO_EL(1);
end
if ismember(FE_model.ELEM_NODE(2,I_ELEM), FE_model.DISP_NODE(:))
    %the second node is prescribed    
    PSEUDO_P(-FE_model.EQ_NUM(FE_model.ELEM_NODE(2,I_ELEM)),iparam)=PSEUDO_EL(2);
else
    PSEUDO_F(FE_model.EQ_NUM(FE_model.ELEM_NODE(2,I_ELEM)),iparam)=PSEUDO_EL(2);
end    
    
%call Element force assemble module with 
%(PS EUDO EL, ELEM NODE, EQ NUM, I ELEM) to
%update (PS EUDO P(:, I PARAM), PS EUDO F(:, I PARAM)) {Update Eqn. 3.61.}
end
if ENTITY_TYPE == 2 %Differentiate wrt displacement
    %not important for now
end
if ENTITY_TYPE == 3 %Differentiate wrt force
    %not important for now
end
end
PSEUDO_F=-PSEUDO_F;