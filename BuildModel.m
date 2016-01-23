load('barrelcolor.mat');
barrel_ycbcr = rgb2ycbcr(X_final);
barrel_model = TrainColor(barrel_ycbcr);
%save model
save('barrel_model.mat', 'barrel_model')