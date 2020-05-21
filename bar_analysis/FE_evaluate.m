function [FE_model] = FE_evaluate(FE_model,UUR,PUR)
FE_model.N_FUNCT=2;

%compliance function
FE_model.THETA(1)=dot(UUR,PUR);
FE_model.D1_PI(1,:)=PUR;
FE_model.D2_PI(1,:)=UUR;
FE_model.D3_PI(1,:)=zeros(1,FE_model.N_ELEM);

%Stiffness function
MAX_STIFF=10;
FE_model.THETA(2)=-MAX_STIFF;
for i=1:FE_model.N_PARAM
    FE_model.THETA(2)=FE_model.THETA(2)+FE_model.PARAM_VAL(i);
end
FE_model.D1_PI(2,:) = 0;
FE_model.D2_PI(2,:) = 0;
for i = 1:FE_model.N_PARAM
FE_model.D3_PI(2,i) = 1;
end