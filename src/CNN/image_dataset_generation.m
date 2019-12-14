clear
load qam_psk_dataset
hwait = waitbar(0,'Generating 0%');

imageDataFolder = 'dataset_qam_psk';
if exist(imageDataFolder,'dir')
    rmdir(imageDataFolder,'s');
end

mkdir(imageDataFolder);


for i = 1:length(dataset)
    labelFolder = [dataset(i).format '_' num2str(dataset(i).bps)];
    fileName = ['snr' num2str(dataset(i).snr) '_' num2str(dataset(i).order) '.png'];
    if ~exist(fullfile(imageDataFolder,labelFolder),'dir')
        mkdir(fullfile(imageDataFolder,labelFolder));
    end
    
    img = signal2image(dataset(i).signal);
%     img = signal2image(dataset(i).signal,20,454);
    imwrite(img,fullfile(imageDataFolder,labelFolder,fileName));
    waitbar(i/length(dataset),hwait,['Generating ' num2str(round(i/length(dataset)*100)) ' %']);
end
close(hwait);