clear
dataset = [];
bitPerSymbolList = 1:5;
snrList = 5:30;
N = 50;
for bitPerSymbol = bitPerSymbolList
    if bitPerSymbol == 1
        continue
    end
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
for bitPerSymbol = bitPerSymbolList
    for snr = snrList
        for i = 1:N
            signal = signal_generation(bitPerSymbol,snr,'psk');
            tmp.signal = signal;
            tmp.format = 'psk';
            tmp.bps = bitPerSymbol;
            tmp.snr = snr;
            tmp.order = i;
        dataset = [dataset tmp];
        end
    end
end
save qam_psk_dataset dataset