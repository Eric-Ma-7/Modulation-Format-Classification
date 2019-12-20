clear
load('trained_cnn','net');
modFormats = [struct('name','2PSK','bitPerSymbol',1,'class','PSK')
    struct('name','8PSK','bitPerSymbol',3,'class','PSK')
    struct('name','16PSK','bitPerSymbol',4,'class','PSK')
    struct('name','QPSK','bitPerSymbol',2,'class','QAM')
    struct('name','8QAM','bitPerSymbol',3,'class','QAM')
    struct('name','16QAM','bitPerSymbol',4,'class','QAM')
    struct('name','32QAM','bitPerSymbol',5,'class','QAM')];

snr = 1;
N = 10000;
validation = cell(N,1);
prediction = [];

hwait = waitbar(0,'Validating 0%');
for i = 1:N
    mod = modFormats(3+randi(4));
    signal = signal_generation(mod.bitPerSymbol,snr,mod.class);
    img = signal2image(signal);
    prediction = [prediction;classify(net,img)];
    validation{i} = mod.name;
    waitbar(i/N,hwait,['Validating ' num2str(round(i/N*100)) '%']);
end
close(hwait);

%% plot heat map
formatList = categories(prediction);
validation = categorical(validation);
heat = zeros(length(formatList));
for i = 1:length(prediction)
    hx = find(formatList==validation(i));
    hy = find(formatList==prediction(i));
    heat(hx,hy) = heat(hx,hy) + 1;
end
figure
heatmap(formatList, formatList, heat);