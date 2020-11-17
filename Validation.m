function [PredictTest_Final, alpha, Beta]=Validation(Training_Data_All,Trainin_Age_All)

[ n , m ] = size (Training_Data_All);

K  = 10; % 10 fold cross validation

cvFolds =  zeros(n,1);
%
for z = 1 :K : n
    for w = 1 : K
        
        cvFolds(z) = w;
        z = z+1;
        % w = w+1 ;
    end
end
cvFolds = cvFolds( 1:n ,:);

Age_HC= Trainin_Age_All; %
PredictTest_Before = zeros(size(Age_HC));



for  i =1:10                                 %for each fold  for i = 1 : K
    testIdx = (cvFolds == i);                % get indices of test instances
    trainIdx = ~testIdx;                     % get indices training instances
 
    DataTrain=Training_Data_All(trainIdx,:);
    AgeTrain=Age_HC(trainIdx,:);
    MainTestData=Training_Data_All(testIdx,:);
    MainTestAge=Age_HC(testIdx,:);
    
    
    %% Regression Model
    X=[];
    Mdl = fitrsvm(DataTrain,AgeTrain,'Standardize',true,'KernelFunction','linear','KernelScale','auto'); % 'KernelScale','auto'
    XX= predict(Mdl,MainTestData);
    PredictTest_Before(testIdx,1)=XX;
    
    
end

%% Computing bias adjustment parameters 
p = polyfit(Trainin_Age_All, (PredictTest_Before-Trainin_Age_All),1);
alpha=p(1);
Beta=p(2);


PredictTest_Final=[];
Offset=mean(alpha).*Trainin_Age_All+mean(Beta);
for t=1:size(PredictTest_Before,1)
    PredictTest_Final(t,1)=PredictTest_Before(t,1)-Offset(t,1);
end



end