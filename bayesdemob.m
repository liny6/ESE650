barrel_model = load('barrel_model.mat');
dir_other_models = dir('other_models/*_model.mat');
modelnum = length(dir_other_models);
other_models = struct('mu', [0, 0, 0], 'A', zeros(3), 'prior', 0);

for i = modelnum:-1:1
    other_models(i) = load(strcat('other_models/', dir_other_models(i).name));
end

dirstruct = dir('data/*.png');
load barrel_model.mat
picnum = 1;

while picnum < length(dirstruct) && picnum
    
    I = imread(strcat('data/', dirstruct(picnum).name));
    [Centers, Angle, Major, Minor] = FindObject(barrel_model, other_models, I);
    
    button = questdlg('Next picture?');
    if strcmp(button,'Yes')
        picnum = picnum + 1;
    else
        picnum = 0;
    end
end