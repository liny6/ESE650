function  TrainColor(X, modelname)
%Train color
%X is transformed YCrCb format (N x 3)
X = rgb2ycbcr(im2double(X));
mu = mean(X);
dis_from_mu = bsxfun(@minus, X, mu);
A_inv = 1/length(X) * (dis_from_mu' * dis_from_mu);
A = inv(A_inv);
prior = length(X)/(50*900*1200);

save(strcat(modelname, '_model.mat'), 'mu', 'A', 'prior');

end

