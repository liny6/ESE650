function LabelImage(directory, colorname)

dirstruct = dir(directory);
X_final = [];

for i = 1 : length(dirstruct)
    name = strcat('data/', dirstruct(i).name);
    I = imread(strcat(name));
    
    imsize = size(I);
    
    figure(1)
    
    userinput = 'Yes';
    
    while strcmp(userinput, 'Yes')
        mask = roipoly(I);
        xyidx = find(mask);
        
        [y, x] = ind2sub([imsize(1), imsize(2)], xyidx);
        xmesh = repmat(x, 1, 3);
        ymesh = repmat(y, 1, 3);
        cmesh = ones(length(x), 1) * [1,2,3];
        indx = sub2ind(imsize, ymesh(:), xmesh(:), cmesh(:));
        X = I(indx);
        X = reshape(X, [length(x), 3]);
        if isempty(X_final)
            X_final = X;
        else
            X_final = [X_final; X];
        end
        userinput = questdlg('more polygon?');
    end
end

name = strcat(colorname, 'color.mat');

save(name, 'X_final');
%prior can be found by labeled pixels over all the pixels
%train model
TrainColor(X_final, colorname);
end
