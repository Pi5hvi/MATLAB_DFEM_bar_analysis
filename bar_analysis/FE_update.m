function [FE_model] = FE_update(FE_model)
for i_param=1:FE_model.N_PARAM
    ENTITY_TYPE=FE_model.PARAM_TYPE(i_param);
    ENTITY_NUM=FE_model.PARAM_ENT_NUM(i_param);
    if ENTITY_TYPE == 1 %Spring
        I_ELEM=ENTITY_NUM;
        FE_model.ELEM_STIFF(I_ELEM)=FE_model.PARAM_VAL(i_param);
    end
    if ENTITY_TYPE == 2 %Change a prescribed displacement
        DISP_NUM = ENTITY_NUM;
        FE_model.DISP_VALUE(DISP_NUM) = FE_model.PARAM_VAL(i_param);
    end
    if ENTITY_TYPE == 3  %Change an external force
        FORCE_NUM = ENTITY_NUM;
        FE_model.FORCE_VALUE(FORCE_NUM) = PARAM_VAL(i_param);
    end
end