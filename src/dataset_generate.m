clear
dataset = [];
for bitPerSymbol = 1:5
    for snr = [10:2:20, 25:5:40]
        signal = signal_generation(bitPerSymbol,snr,'psk');
        tmp.signal = signal;
        tmp.format = 'psk';
        tmp.bps = bitPerSymbol;
        tmp.snr = snr;
        dataset = [dataset tmp];
    end
end
for bitPerSymbol = 1:5
    for snr = [10:2:20, 25:5:40]
        signal = signal_generation(bitPerSymbol,snr,'qam');
        tmp.signal = signal;
        tmp.format = 'qam';
        tmp.bps = bitPerSymbol;
        tmp.snr = snr;
        dataset = [dataset tmp];
    end
end
save dataset dataset