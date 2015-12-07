function rmse = getRMSE(f0,pred_f0)

    N = length(f0);
    %tmp = (log(f0) - log(pred_f0)).^2;
    tmp = (exp(f0) - exp(pred_f0)).^2;
    rmse = sqrt(1.0/N*sum(tmp));
