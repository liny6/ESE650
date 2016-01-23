function VisualizeColorSeg(P_vectorized, IMnr, IMnc)
%for debugging
[~, num_segs] = size(P_vectorized);

for i = 1:num_segs
    figure(i)
    Forshow = reshape(P_vectorized(:, i), IMnr, IMnc);
    imagesc(Forshow)
end


end

