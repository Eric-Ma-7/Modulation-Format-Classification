clear
% load SVMModel
load SVMModel_2PSK.mat
load SVMModel_8QAM.mat
load SVMModel_32QAM.mat

quantity = 100;
testData = dataset_generate('random','random',quantity);% generate test data
trainLabel = cell(quantity,1);
[trainLabel{:,1} ] = testData.format;   % get the label of data
data = satatisticaldata_genarate(testData);% get satatistical data

[m,n] =  size(data);
%% 2PSK
result_2PSK = predict(SVMModel_2PSK,data);
result = cell(m,1);
for j=1:m
    if isequal(result_2PSK(j),trainLabel(j))
        result(j)={'2PSK'};
    end
end
%% 8QAM
result_8QAM = predict(SVMModel_8QAM,data);
for j=1:m
    if isequal(result_8QAM(j),trainLabel(j))
        result(j)={'8QAM'};
    end
end
%% 32QAM
result_32QAM = predict(SVMModel_32QAM,data);
for j=1:m
    if isequal(result_32QAM(j),trainLabel(j))
        result(j)={'32QAM'};   
    end
end
%% 16QAM & QPSK & 8SPK. DO NOT use SVMModel to classify
for j=1:m
    if isequal(result(j),{[]})
        C20 = M(testData(j).signal,2,0);
        C40 = M(testData(j).signal,4,0)-3*C20^2;
        if (abs(C40)<0.1)
            result(j)={'8PSK'};
        elseif data.T4(j) < 0.788
            result(j)={'16QAM'};
        else
            result(j)={'QPSK'};
        end
    end
end
%% calculate accuracy
rightNum = 0;
sum = 0;
for j=1:m
    if isequal(result(j),trainLabel(j))
        rightNum = rightNum+1;
    end
    sum = sum+1;
end
disp(rightNum/sum*100)