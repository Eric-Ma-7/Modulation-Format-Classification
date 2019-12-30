% 计算不同SNR下训练的模型使用范围，给出正确率随着SNR变化的图
accurancy=0:200;
svm_train(1);
load SVMModel_2PSK.mat
load SVMModel_QPSK.mat
load SVMModel_8PSK.mat
load SVMModel_8QAM.mat
load SVMModel_16QAM.mat
load SVMModel_32QAM.mat
for snr=0:200
quantity = 100;
testData = dataset_generatation('random',snr/10,quantity);% generate test data
trainLabel = cell(quantity,1);
[trainLabel{:,1} ] = testData.format;   % get the label of data
data = satatisticaldata_genarate(testData);% get satatistical data

[m,n] =  size(data);
result = cell(m,1);

%% 2PSK
result_2PSK = predict(SVMModel_2PSK,data);

for j=1:m
    if isequal(result_2PSK(j),trainLabel(j))
        result(j)={'2PSK'};
    end
end
%% QPSK
result_QPSK = predict(SVMModel_QPSK,data);
for j=1:m
    if isequal(result_QPSK(j),trainLabel(j))
        result(j)={'QPSK'};
    end
end
%% 8QAM
result_8QAM = predict(SVMModel_8QAM,data);
for j=1:m
    if isequal(result_8QAM(j),trainLabel(j))
        result(j)={'8QAM'};
    end
end
%% 16QAM
result_16QAM = predict(SVMModel_16QAM,data);
for j=1:m
    if isequal(result_16QAM(j),trainLabel(j))
        result(j)={'16QAM'};   
    end
end
%% 32QAM
result_32QAM = predict(SVMModel_32QAM,data);
for j=1:m
    if isequal(result_32QAM(j),trainLabel(j))
        result(j)={'32QAM'};   
    end
end
%% 8PSK
result_8PSK = predict(SVMModel_8PSK,data);
for j=1:m
    if isequal(result_8PSK(j),trainLabel(j))
        result(j)={'8PSK'};   
    end
end
%% NONE
for j=1:m
    if isequal(result(j),{[]})
        result(j)={'8QAM'};     % All unknown formats are assumed to be 8QAM   
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
accurancy(snr+1) = rightNum/sum*100;
end
x=0:200;
plot(x/10,accurancy,'.')
p = smoothdata(accurancy,'gaussian',10);
hold on
plot(x/10,p,'Color',[0 0.4470 0.7410])
xlabel('SNR/dB');
ylabel('Accurancy/%');

