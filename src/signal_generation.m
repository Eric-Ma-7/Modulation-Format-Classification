function RxSignal = signal_generation(bitPerSymbol,snr,varargin)
% This function is to generate signals with different digital
% baseband modulation format (PSK,QPSK,8QAM,16QAM,32QAM...)
% under additive white Gaussian noise (AWGN) channel.
% 
% bitPerSymbol - the information quantity of a single symbol
% 	       snr - signal noise ratio with unit of dB
%     RxSignal - output signals
if nargin == 2
    dataNum = 10000;
else
    dataNum = varargin{1};
end

M = 2^bitPerSymbol;
dataSymbol = randi([0,M-1],1,dataNum);
if bitPerSymbol == 3
    constel = [1+1i, -1+1i, -1-1i, 1-1i, 1+sqrt(3), (1+sqrt(3))*1i, -1-sqrt(3), -(1+sqrt(3))*1i];
    TxSignal = constel(dataSymbol+1);
else
    TxSignal = qammod(dataSymbol,M,'gray');
end
RxSignal = awgn(TxSignal,snr,'measured');
end