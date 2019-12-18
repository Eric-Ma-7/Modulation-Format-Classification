function  [result] = M(X,p,q)
m1 = X.^(p-q).*(conj(X)).^q;
result=mean(m1);

