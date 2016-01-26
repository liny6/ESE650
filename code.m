dirstruct = dir('data/*.png');
for i = 1:length(dirstruct),
    % Read one test image
    im = imread(dirstruct(i).name);
    
    % Your computations here!
    [x, y, d] = FindObjectWrapper(im);
    
    % Display results:
    % (1) Segmented image
    % (2) Barrel center
    % (3) Distance of barrel
    % You may also want to plot and display other diagnostic information
    
    hold off;
    pause;
end