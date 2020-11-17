function [MAE, RMSE, Delta_Age, R2,CI_min,CI_max]=Performance(Predicted_Age,Real_Age)


MAE=sum(abs(Predicted_Age -Real_Age))/numel(Real_Age);
RMSE= (mean((Predicted_Age -Real_Age).^2))^0.5;
Delta_Age=mean((Predicted_Age -Real_Age));
[R, Pvalue] = corr(Real_Age,Predicted_Age);
R2 = R.*R;

%% 

SEM = std(Predicted_Age -Real_Age)/sqrt(length(Predicted_Age -Real_Age));               % Standard Error
ts = tinv([0.025  0.975],length(Predicted_Age -Real_Age)-1);      % T-Score
CI = mean(Predicted_Age -Real_Age) + ts*SEM;
CI_min=CI(1);
CI_max=CI(2);


end