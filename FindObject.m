function [Centers, Angle, Major, Minor] = FindObject(object_model, other_models, I)
%Object model is a single struct, while other models is a nx1 struct array

%%
otherlength = length(other_models);
[nr, nc, ~] = size(I);

%% pull out mean and covariance from barrel model
mu_object = object_model.mu;
A_object = object_model.A;
prior_object = object_model.prior;

%% pull out the rest of the model means, variances and priors
mu_other = zeros(otherlength, 3);
A_other = cell(otherlength, 1);
prior_other = zeros(otherlength, 1);

for i = 1:otherlength
    mu_other(i, :) = other_models(i).mu;
    A_other{i} = other_models(i).A;
    prior_other(i) = other_models(i).prior;
end    

%% set up the 3 d gaussian distribution function
P_x = @(x, mu, A, prior) prior * sqrt(det(A)/(2*pi)^3) * exp(-0.5 * sum(bsxfun(@minus, x, mu) * A .* bsxfun(@minus, x, mu),2));

%% calculate the probability of the pixel being the object

I_vec = rgb2ycbcr(reshape(im2double(I), [nr*nc, 3]));
P_object = P_x(I_vec, mu_object, A_object, prior_object);

%% calculate the probability of the pixel being other shit
P_others = zeros(length(I_vec), otherlength);

for i = 1:otherlength
    P_others(:, i) = P_x(I_vec, mu_other(i, :), A_other{i}, prior_other(i));
end

%compare probability
[P_others_max] = max(P_others, [], 2);
BW = bsxfun(@gt, P_object, P_others_max);

%thresholding
max_object_val = max(P_object(BW));
candidate = bitand(BW, (P_object > 0.05*max_object_val));
candidate = reshape(candidate, [nr, nc]);


%VisualizeColorSeg(P_others, nr, nc);

%dilate BW
dilate_kern = ones(15);
candidate = double(candidate);
candidate = conv2(candidate, dilate_kern, 'same');
candidate = candidate ~= 0;

figure(4)
imshow(candidate)

Centers = 1;
Angle = 1;
Major = 1;
Minor = 1;





%% detect blobs and filter based on geometry
stats = regionprops('table', candidate, 'Centroid', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Area');
%filter based on blob size
size_bool = stats.Area >= 0.4*max(stats.Area);

%dilate all the blobs that are big enough


%filter based on aspect ratio
ASR = stats.MajorAxisLength./stats.MinorAxisLength;
ASR_bool = bitand( (ASR > 1.2), (ASR < 1.8) );

final_ind = bitand(size_bool, ASR_bool);

Centers = stats.Centroid(final_ind, :);
Angle = stats.Orientation(final_ind);
Major = stats.MajorAxisLength(final_ind);
Minor = stats.MinorAxisLength(final_ind);

figure(1)
imshow(I)

for i = 1:length(Angle)

R = [cosd(Angle(i)), sind(Angle(i));
     -sind(Angle(i)), cosd(Angle(i))];

Vertex1 = Centers(i, :) + (0.5*R*[Major(i); Minor(i)])';
Vertex2 = Centers(i, :) + (0.5*R*[Major(i); -Minor(i)])';
Vertex3 = Centers(i, :) + (0.5*R*[-Major(i); Minor(i)])';
Vertex4 = Centers(i, :) + (0.5*R*[-Major(i); -Minor(i)])';

drawbbx(Vertex1, Vertex2, Vertex3, Vertex4)
end



%}

end

