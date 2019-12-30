function quantity = svm_train(snr)
% This program is only used to train SVM Models for 2PSK,8QAM and 32QAM
quantity = 200;
trainingData = dataset_generatation('random',snr,quantity);% 200sets of data for training,snr=10
trainLabel = cell(quantity,1);
[trainLabel{:,1} ] = trainingData.format; % get label

data = satatisticaldata_genarate(trainingData);% get  satatistical data

[m,n] =  size(data);
label = cell(quantity,1);
%% 2PSK
for j=1:m
    if strcmp(trainingData(j).format,'2PSK')
        label(j) = {'2PSK'};
    else
        label(j) = {'others'};
    end
end
SVMModel_2PSK = fitcsvm(data,label,'KernelFunction','polynomial');
save SVMModel_2PSK SVMModel_2PSK
%% 8PSK
for j=1:m
    if strcmp(trainingData(j).format,'8PSK')
        label(j) = {'8PSK'};
    else
        label(j) = {'others'};
    end
end
SVMModel_8PSK = fitcsvm(data,label,'KernelFunction','polynomial');
save SVMModel_8PSK SVMModel_8PSK
%% 8QAM
for j=1:m
    if strcmp(trainingData(j).format,'8QAM')
        label(j) = {'8QAM'};
    else
        label(j) = {'others'};
    end
end
SVMModel_8QAM = fitcsvm(data,label,'KernelFunction','linear');
save SVMModel_8QAM SVMModel_8QAM
%% 32QAM
for j=1:m
    if strcmp(trainingData(j).format,'32QAM')
        label(j) = {'32QAM'};
    else
        label(j) = {'others'};
    end
end
SVMModel_32QAM = fitcsvm(data,label,'KernelFunction','polynomial');
save SVMModel_32QAM SVMModel_32QAM
%% QPSK
for j=1:m
    if strcmp(trainingData(j).format,'QPSK')
        label(j) = {'QPSK'};
    else
        label(j) = {'others'};
    end
end
SVMModel_QPSK = fitcsvm(data,label,'KernelFunction','polynomial');
save SVMModel_QPSK SVMModel_QPSK
%% 16QAM
for j=1:m
    if strcmp(trainingData(j).format,'16QAM')
        label(j) = {'16QAM'};
    else
        label(j) = {'others'};
    end
end
SVMModel_16QAM = fitcsvm(data,label,'KernelFunction','polynomial');
save SVMModel_16QAM SVMModel_16QAM
end
