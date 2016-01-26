function [ x, y, d ] = FindObjectWrapper( im )
%this function only works when the models are present in the directory
d = 1; % this is just dummy for now

%% load up models
dir_other_models = dir('other_models/*_model.mat');
modelnum = length(dir_other_models);
other_models = struct('mu', [0, 0, 0], 'A', zeros(3), 'prior', 0);

for i = modelnum:-1:1
    other_models(i) = load(strcat('other_models/', dir_other_models(i).name));
end

%% run segmentation function
[Centers, ~, ~, ~] = FindObject(barrel_model, other_models, im);
x = Centers(:,2);
y = Centers(:,1);

end

