function snr=snr_estimation(signal,format)
load SNRModel_2PSK.mat
load SNRModel_QPSK.mat
load SNRModel_8PSK.mat
load SNRModel_8QAM.mat
load SNRModel_16QAM.mat
load SNRModel_32QAM.mat
x = real(signal);
y= imag(signal);
tmp = [x;y];
tmp = tmp';
%tmp = tmp1(randsample(10000,1000,'false'),:);
switch format
    case '2PSK'
        [idx,C,sumD] = kmeans(tmp,2);
        logSumD = log10(mean(sumD));
        f=@(x)SNRModel_2PSK(1)*x.^2+SNRModel_2PSK(2)*x+SNRModel_2PSK(3)-logSumD;
    case 'QPSK'
        [idx,C,sumD] = kmeans(tmp,4);
        logSumD = log10(mean(sumD));
        f=@(x)SNRModel_QPSK(1)*x.^2+SNRModel_QPSK(2)*x+SNRModel_QPSK(3)-logSumD;
    case '8PSK'
        [idx,C,sumD] = kmeans(tmp,8);
        logSumD = log10(mean(sumD));
        f=@(x)SNRModel_8PSK(1)*x.^2+SNRModel_8PSK(2)*x+SNRModel_8PSK(3)-logSumD;
    case '8QAM'
        [idx,C,sumD] = kmeans(tmp,8);
        logSumD = log10(mean(sumD));
        f=@(x)SNRModel_8QAM(1)*x.^2+SNRModel_8QAM(2)*x+SNRModel_8QAM(3)-logSumD;
    case '16QAM'
        [idx,C,sumD] = kmeans(tmp,16);
        logSumD = log10(mean(sumD));
        f=@(x)SNRModel_16QAM(1)*x.^2+SNRModel_16QAM(2)*x+SNRModel_16QAM(3)-logSumD;
    case '32QAM'
        [idx,C,sumD] = kmeans(tmp,32);
        logSumD = log10(mean(sumD));
        f=@(x)SNRModel_32QAM(1)*x.^2+SNRModel_32QAM(2)*x+SNRModel_32QAM(3)-logSumD;
end
snr = fzero(f,10);
end
