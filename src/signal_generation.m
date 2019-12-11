clear;
% signal generation
% Use 100 loops to generate 100 sets of data
for j = 4:4  % bit per symbol: 1. PSK; 2. QPSK; 3.8QAM; 4. 16QAM; 5. 32QAM; 6.64QAM...
System.BitPerSymbol = j;
snr = 12:15;  % set SNR (dB)
for snrIndex= 1:length(snr)

Tx.SampleRate = 32e9; % symbol Rate
Tx.Linewidth = 0;% Linewidth of Transmitting signal carrier wave
Tx.Carrier = 0;% Frequency of Transmitting signal carrier wave
M = 2^System.BitPerSymbol;

Tx.DataSymbol = randi([0 M-1],1,10000);

% generate data with different modulations
% set the 2^3 (8QAM) modulation alone to realize the optimal 8QAM constellation diagram
if M ~= 8
    Tx.DataConstel = qammod(Tx.DataSymbol,M,'gray');
else
	tmp = Tx.DataSymbol;
	tmp2  = zeros(1,length(Tx.DataSymbol));
	for kk = 1:length(Tx.DataSymbol)
        switch tmp(kk)
            case 0
                tmp2(kk) = 1 + 1i;
            case 1
                tmp2(kk) = -1 + 1i;
            case 2
                tmp2(kk) = -1 - 1i;
            case 3
                tmp2(kk) = 1 - 1i;
            case 4
                tmp2(kk) = 1+sqrt(3);
            case 5
                tmp2(kk) = 0 + 1i .* (1+sqrt(3));
            case 6
                tmp2(kk) = 0 - 1i .* (1+sqrt(3));
            case 7
                tmp2(kk) = -1-sqrt(3);
        end
	end
	Tx.DataConstel = tmp2;
	clear tmp tmp2;
end

Tx.Signal = Tx.DataConstel;

% Load data onto carrier wave (consider noise)
N = length(Tx.Signal);
dt = 1/Tx.SampleRate;
t = dt*(0:N-1);
Phase1 = [0, cumsum(normrnd(0,sqrt(2*pi*Tx.Linewidth/(Tx.SampleRate)), 1, N-1))];
carrier1 = exp(1i*(2*pi*t*Tx.Carrier + Phase1));
Tx.Signal = Tx.Signal.*carrier1;

% Receive data under AWGN channel
Rx.Signal = awgn(Tx.Signal,snr(snrIndex),'measured');

CMAOUT = Rx.Signal;

% normalization of received data
CMAOUT=CMAOUT/sqrt(mean(abs(CMAOUT).^2));

subplot(1,4,snrIndex);
plot(Rx.Signal,'.');

end
end







