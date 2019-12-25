function RxSignal = signal_generation(bitPerSymbol,snr,format,varargin)
% This function is to generate signals with different digital
% baseband modulation format (PSK,QPSK,8QAM,16QAM,32QAM...)
% under additive white Gaussian noise (AWGN) channel.
% 
% bitPerSymbol - the information quantity of a single symbol
% 	       snr - signal noise ratio with unit of dB
%       format - modulation format (PSK or QAM)
%     RxSignal - output signals
if nargin == 3
    dataNum = 10000;
elseif nargin == 4
    dataNum = varargin{1};
elseif nargin == 5
    dataNum = varargin{1};
    phzNoise = varargin{2};
end

M = 2^bitPerSymbol;
dataSymbol = randi([0,M-1],dataNum,1);
if strcmp(format,'psk')||strcmp(format,'PSK')
	TxSignal = pskmod(dataSymbol,M,0);
elseif strcmp(format,'qam')||strcmp(format,'QAM')
    if bitPerSymbol == 3
        constel = [1+1i; -1+1i; -1-1i; 1-1i; 1+sqrt(3); (1+sqrt(3))*1i; -1-sqrt(3); -(1+sqrt(3))*1i];
        TxSignal = constel(dataSymbol+1);
    else
        TxSignal = qammod(dataSymbol,M,'gray');
    end
end
if nargin == 5
    TxSignal = phzNoise(TxSignal);
end
RxSignal = awgn(TxSignal,snr,'measured');
end