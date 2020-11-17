function [Predict_Test]=BrainAge_Test(Training_Data,Training_Age,Alpha, Beta,Test_Data, Test_Age) ;



Mdl_onTest = fitrsvm(Training_Data,Training_Age,'Standardize',true,'KernelFunction','linear','KernelScale','auto'); % 'KernelScale','auto'


Precicted_Test_Before= predict(Mdl_onTest,Test_Data);

Predict_Test=[];
Offset=mean(Alpha).*Test_Age+mean(Beta);
for t=1:size(Precicted_Test_Before,1)
    Predict_Test(t,1)=Precicted_Test_Before(t,1)-Offset(t,1);
end




end