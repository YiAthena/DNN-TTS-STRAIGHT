function MCD= getMCD( A,B )
    tmp = (A-B).^2;
    tmp = 10*sqrt(2)/log(10)*sqrt(sum(tmp,2)); % T x 1
    MCD = mean(tmp);

end