clear
%% image data preprocessing
imdsFolder = [pwd '\dataset_qam_psk'];

imds = imageDatastore(imdsFolder,'IncludeSubfolders',true,'LabelSource','foldernames');
numTrainFiles = 1100;
[imdsTrain, imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

%% Define CNN
myLayers = [
    imageInputLayer([454 454 1])
    
    convolution2dLayer(5,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(7)
    softmaxLayer
    classificationLayer];

%% Training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',50, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',10, ...
    'Verbose',false, ...
    'Plots','training-progress');

%% Train
net = trainNetwork(imdsTrain,myLayers,options);

%% Validation
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation);
disp(['accuracy =' num2str(accuracy)]);