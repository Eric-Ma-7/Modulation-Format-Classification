clear
dataset = [];
bitPerSymbolList = 2:5;
snrList = 5:30;
N = 50;
for bitPerSymbol = bitPerSymbolList
    for snr = snrList
        for i = 1:N
            signal = signal_generation(bitPerSymbol,snr,'qam');
            tmp.signal = signal;
            tmp.format = 'qam';
            tmp.bps = bitPerSymbol;
            tmp.snr = snr;
            tmp.order = i;
            dataset = [dataset tmp];
        end
    end
end
save dataset dataset