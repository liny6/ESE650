function LabelImage(directory)
dirstruct = dir(directory);
for i = 1% : length(dirstruct)
    name = strcat('data/', dirstruct(i).name);
    I = imread(strcat(name));
    
    imsize = size(I);
    
    figure(1)
    mask = roipoly(I);
    xyidx = find(mask);
    
    [y, x] = ind2sub([imsize(1), imsize(2)], xyidx);
    xmesh = repmat(x, 1, 3);
    ymesh = repmat(y, 1, 3);
    cmesh = ones(length(x), 1) * [1,2,3];
    indx = sub2ind(imsize, ymesh(:), xmesh(:), cmesh(:));
    X = I(indx);
    X = reshape(X, [length(x), 3]);
    
end
end
