% This program is only used to train SVM Models for 2PSK,8QAM and 32QAM
quantity = 200;
trainingData = dataset_generate('random',10,quantity);% 200sets of data for training,snr=10
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
SVMModel_2PSK = fitcsvm(data,label,'KernelFunction','linear');
save SVMModel_2PSK SVMModel_2PSK
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
SVMModel_32QAM = fitcsvm(data,label,'KernelFunction','linear');
save SVMModel_32QAM SVMModel_32QAM