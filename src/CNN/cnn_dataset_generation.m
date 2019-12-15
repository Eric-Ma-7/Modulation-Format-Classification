clear
modFormats = [struct('name','2PSK','bitPerSymbol',1,'class','PSK')
    struct('name','8PSK','bitPerSymbol',3,'class','PSK')
    struct('name','16PSK','bitPerSymbol',4,'class','PSK')
    struct('name','QPSK','bitPerSymbol',2,'class','QAM')
    struct('name','8QAM','bitPerSymbol',3,'class','QAM')
    struct('name','16QAM','bitPerSymbol',4,'class','QAM')
    struct('name','32QAM','bitPerSymbol',5,'class','QAM')];

%% generating signals
snrList = 5:30;
N = 50;
dataset = [];

hwait = waitbar(0,'Generating signals 0%');
for i = 1:7
    for snr = snrList
        for j = 1:N
            mod = modFormats(i);
            signal = signal_generation(mod.bitPerSymbol,snr,mod.class);
            tmp.signal = signal;
            tmp.bps = mod.bitPerSymbol;
            tmp.snr = snr;
            tmp.class = mod.class;
            tmp.name = mod.name;
            tmp.order = j;
            dataset = [dataset;tmp];
            
            frac = length(dataset)/(7*N*length(snrList));
            waitbar(frac,hwait,['Generating signals ' num2str(round(frac*100)) '%']);
        end
    end
end

%% Preparing dataset
imageDataFolder = 'dataset_cnn_train';
if exist(imageDataFolder,'dir')
    rmdir(imageDataFolder,'s');
end

mkdir(imageDataFolder);

waitbar(0,hwait,'Preparing dataset 0%')
for i = 1:length(dataset)
    labelFolder = dataset(i).name;
    fileName = [dataset(i).name '_snr' num2str(dataset(i).snr) '_' num2str(dataset(i).order) '.png'];
    if ~exist(fullfile(imageDataFolder,labelFolder),'dir')
        mkdir(fullfile(imageDataFolder,labelFolder));
    end
    
    img = signal2image(dataset(i).signal);
    imwrite(img,fullfile(imageDataFolder,labelFolder,fileName));
    waitbar(i/length(dataset),hwait,['Preparing dataset ' num2str(round(i/length(dataset)*100)) ' %']);
end

close(hwait);