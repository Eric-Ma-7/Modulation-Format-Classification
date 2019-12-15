clear
load trained_cnn net
imdsFolder = [pwd '\dataset_qam_psk'];
imds = imageDatastore(imdsFolder,'IncludeSubfolders',true,'LabelSource','foldernames');

pred = classify(net,imds);
validation = imds.Labels;
%%
modFormat = categories(pred);
heat = zeros(length(modFormat));
for i = 1:length(pred)
    hx = find(modFormat==validation(i));
    hy = find(modFormat==pred(i));
    heat(hx,hy) = heat(hx,hy) + 1;
end
heatmap(modFormat, modFormat, heat);
    

