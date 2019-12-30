a=1:21;
for snr=0:20
signal=signal_generation(1,snr,'psk',100000);
x = real(signal);
y= imag(signal);
tmp=[x;y];
tmp=tmp';
[idx,C,sumD] = kmeans(tmp,2);
sumD=sum(sumD)
a(snr+1)=10*log10(100000/sumD)
end
plot(0:20,0:20)
hold on
plot([0:20],a)