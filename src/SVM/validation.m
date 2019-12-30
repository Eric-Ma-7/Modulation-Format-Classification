tic
correctRate=1:20;
correctSNRRate=1:20;
for snr=1:20
n=10;
svm_train(n);
dataset = dataset_generatation('random',snr,100);

for j=1:11
    re = identification(dataset);
    tmp = cell2mat(re(:,2));
    if mean(tmp) > 11
        break;
    end
    if isnan(mean(tmp))
        n=n-1;
        svm_train(n); 
        continue
    end
    if std(tmp)>=1
        n = n-1;
        svm_train(n); 
        continue
    end
    if round(mean(tmp)) == n
        break;
    end
    n = round(mean(tmp));
    svm_train(n);   
end

for jj=1:100
    if isequal(re(jj,1),{[]})
        re(jj,1)={'16QAM'};  % ²ÂÒ»¸ö°É
    end
    if isequal(re(jj,2),{[]})
        re(jj,2)= {0};
    end
    if isnan(cell2mat(re(jj,2)))
        re(jj,2)= {0};
    end
end

correctFormatNum = 0;
correctSNRNum=0;
for jj=1:100
    if isequal(cell2mat(re(jj,1)),dataset(jj).format)
        correctFormatNum = correctFormatNum+1;
    end
    if cell2mat(re(jj,2))>=dataset(jj).snr-1.5 && cell2mat(re(jj,2))<=dataset(jj).snr+1.5
        correctSNRNum = correctSNRNum+1;
    elseif cell2mat(re(jj,2))>=10 && dataset(jj).snr>=10
        correctSNRNum = correctSNRNum+1;
    end
end

correctFormatRate(snr) = correctFormatNum;
correctSNRRate(snr) = correctSNRNum;
end
plot(1:20,correctFormatRate,'s-')
hold on;
plot(1:20,correctSNRRate,'s-')
legend('Format Accurancy','SNR Accurancy','location','southeast')
xlabel('SNR/dB')
ylabel('Accurancy/%')
toc
