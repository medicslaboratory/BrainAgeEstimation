clc
close all
clear all

load('Data.mat')

Training_Data=Data.Train.CH_F.PET;
Training_Age=Data.Train.CH_F.Age;


%% Validation
[Predicted_Validation, Alpha, Beta]=Validation(Training_Data,Training_Age) ;

[MAE_Validation, RMSE_Validation, Delta_Age_Validation, R2_Validation,CI_min_Validation,CI_max_Validation]=Performance(Predicted_Validation,Training_Age); 
   
[r_Validation,p_Validation]=corr(Predicted_Validation-Training_Age,Training_Age);





%% Test on CH-F data
[Predicted_CHF]=BrainAge_Test(Training_Data,Training_Age,Alpha, Beta,Data.Test.CH_F.PET, Data.Test.CH_F.Age ) ;
[MAE_CHF, RMSE_CHF, Delta_Age_CHF, R2_CHF,CI_min_CHF,CI_max_CHF]=Performance(Predicted_CHF,Data.Test.CH_F.Age);
[r_CHF,p_CHF]=corr(Predicted_CHF-Data.Test.CH_F.Age,Data.Test.CH_F.Age);


%% Test on CH-M data
[Predicted_CHM]=BrainAge_Test(Training_Data,Training_Age,Alpha, Beta,Data.Test.CH_M.PET, Data.Test.CH_M.Age ) ;
[MAE_CHM, RMSE_CHM, Delta_Age_CHM, R2_CHM,CI_min_CHM,CI_max_CHM]=Performance(Predicted_CHM,Data.Test.CH_M.Age);



%% Test on MCI-F data
[Predicted_MCIF]=BrainAge_Test(Training_Data,Training_Age,Alpha, Beta,Data.Test.MCI_F.PET, Data.Test.MCI_F.Age ) ;
[MAE_MCIF, RMSE_MCIF, Delta_Age_MCIF, R2_MCIF,CI_min_MCIF,CI_max_MCIF]=Performance(Predicted_MCIF,Data.Test.MCI_F.Age);


%% Test on MCI-M data
[Predicted_MCIM]=BrainAge_Test(Training_Data,Training_Age,Alpha, Beta,Data.Test.MCI_M.PET, Data.Test.MCI_M.Age ) ;
[MAE_MCIM, RMSE_MCIM, Delta_Age_MCIM, R2_MCIM,CI_min_MCIM,CI_max_MCIM]=Performance(Predicted_MCIM,Data.Test.MCI_M.Age);



%% Test on AD-F data
[Predicted_ADF]=BrainAge_Test(Training_Data,Training_Age,Alpha, Beta,Data.Test.AD_F.PET, Data.Test.AD_F.Age ) ;
[MAE_ADF, RMSE_ADF, Delta_Age_ADF, R2_ADF,CI_min_ADF,CI_max_ADF]=Performance(Predicted_ADF,Data.Test.AD_F.Age);


%% Test on AD-M data
[Predicted_ADM]=BrainAge_Test(Training_Data,Training_Age,Alpha, Beta,Data.Test.AD_M.PET, Data.Test.AD_M.Age ) ;
[MAE_ADM, RMSE_ADM, Delta_Age_ADM, R2_ADM,CI_min_ADM,CI_max_ADM]=Performance(Predicted_ADM,Data.Test.AD_M.Age);




[h_CH,p_CH,ci_CH,stats_CH]=ttest2(Predicted_CHM-Data.Test.CH_M.Age, Predicted_CHF-Data.Test.CH_F.Age);

[h_MCI,p_MCI,ci_MCI,stats_MCI]=ttest2(Predicted_MCIM-Data.Test.MCI_M.Age,Predicted_MCIF-Data.Test.MCI_F.Age);

[h_AD,p_AD,ci_AD,stats_AD]=ttest2(Predicted_ADM-Data.Test.AD_M.Age,Predicted_ADF-Data.Test.AD_F.Age);




%% Summary of brain age estimation results in diffrent groups

Group = {'Training set : CH_F';'Test set : CH_F';'Test set : CH_M';'Test set : MCI_F';'Test set : MCI_M';'Test set : AD_F';'Test set : AD_M'};
MAE = [MAE_Validation;MAE_CHF;MAE_CHM;MAE_MCIF;MAE_MCIM;MAE_ADF;MAE_ADM];
RMSE = [RMSE_Validation;RMSE_CHF;RMSE_CHM;RMSE_MCIF;RMSE_MCIM;RMSE_ADF;RMSE_ADM];
R2 = [R2_Validation;R2_CHF;R2_CHM;R2_MCIF;R2_MCIM;R2_ADF;R2_ADM];
Brain_Age_Gap = [Delta_Age_Validation;Delta_Age_CHF;Delta_Age_CHM;Delta_Age_MCIF;Delta_Age_MCIM;Delta_Age_ADF;Delta_Age_ADM];
CI_min=[CI_min_Validation;CI_min_CHF;CI_min_CHM;CI_min_MCIF;CI_min_MCIM;CI_min_ADF;CI_min_ADM];
CI_max=[CI_max_Validation;CI_max_CHF;CI_max_CHM;CI_max_MCIF;CI_max_MCIM;CI_max_ADF;CI_max_ADM];
Summary_of_BrainAge = table(Group,MAE,RMSE,R2,Brain_Age_Gap,CI_min,CI_max)



%% Statistical tests between female and males in diffrent groups

Group = {'CH_F vs CH_M';'MCI_F vs. MCI_M ';'AD_F vs. AD_M'};
t_test = [stats_CH.tstat;stats_MCI.tstat;stats_AD.tstat];
p_value = [p_CH;p_MCI;p_AD];
ttest_results = table(Group,t_test,p_value)


