function drawbbx(v1, v2, v3, v4)
%DRAWBBX Summary of this function goes here
%   Detailed explanation goes here
hold on

[nc, ~] = size(v1);


plot([v1( 1); v2(1)], [v1( 2); v2(2)], 'y')
plot([v1( 1); v3(1)], [v1( 2); v3(2)], 'y')
plot([v2( 1); v4(1)], [v2( 2); v4(2)], 'y')
plot([v3( 1); v4(1)], [v3( 2); v4(2)], 'y')


end

