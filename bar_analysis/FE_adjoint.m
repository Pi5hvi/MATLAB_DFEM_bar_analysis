function [FE_model,GRAD_THETA] = FE_adjoint(FE_model,UUR,PUR,Kff,Kfp)

[FE_model] = FE_evaluate(FE_model,UUR,PUR);
%rearranging D1_PI_UR and D2_PI_UR

FE_model.D1_PI_P=zeros(FE_model.N_FUNCT,FE_model.N_PRE_DISP);
FE_model.D1_PI_F=zeros(FE_model.N_FUNCT,FE_model.N_DOF);
FE_model.D2_PI_P=zeros(FE_model.N_FUNCT,FE_model.N_PRE_DISP);
FE_model.D2_PI_F=zeros(FE_model.N_FUNCT,FE_model.N_DOF);

for i=1:FE_model.N_FUNCT
    for j=1:FE_model.N_PRE_DISP
        FE_model.D1_PI_P(i,j)=FE_model.D1_PI(i,find(FE_model.EQ_NUM==-j));
        FE_model.D2_PI_P(i,j)=FE_model.D2_PI(i,find(FE_model.EQ_NUM==-j));
    end
    for j=1:FE_model.N_DOF
        FE_model.D1_PI_F(i,j)=FE_model.D1_PI(i,find(FE_model.EQ_NUM==j));
        FE_model.D2_PI_F(i,j)=FE_model.D2_PI(i,find(FE_model.EQ_NUM==j));
    end
end

%Loop over functions

FE_model.LAMBDA_P = -FE_model.D2_PI_P;
%[Kpp, Kpf, Kff, Kfp, PF, UP] = FE_assemble_all(FE_model);
FE_model.LAMBDA_F =(Kff\(FE_model.D1_PI_F.'-Kfp*FE_model.LAMBDA_P.')).';
[PSEUDO_P,PSEUDO_F,D_UP,D_PF,FE_model] = FE_pseudo_force(FE_model,UUR);
GRAD_THETA= (FE_model.D1_PI_P*D_UP+FE_model.D2_PI_F*D_PF+FE_model.D3_PI+FE_model.LAMBDA_F*PSEUDO_F-FE_model.LAMBDA_P*PSEUDO_P).';
 