%the map is a point cloud with [0,0,0] being the robots starting position
if k > 2
    %instead of using the already computed point cloud, I want to 
    % reproject the image using the past interpolated depth map.
    ptCloud = pointCloud([ptCloud.Location; ...
        applymove2PC( ...
        downsample(reprojectImage(Images{1,1}, InterpolatedDM{1}),10) ...
        , Robot{k,2}, Robot{k,1})]);
     
else %create the Map
    ptCloud = pointCloud(downsample(reprojectImage(Images{1,1}, InterpolatedDM{1}),10));
end
ptCloud = pcdenoise(ptCloud);

function outPtC = applymove2PC(ptC, X, w)
        angle1 = atan2(ptC(1),ptC(3));
        angle2 = angle1 - w;
        R = norm([ptC(1),0,ptC(3)],2);
        ptC(1) = R*cos(angle2);
        ptC(3) = R*sin(angle2);
        outPtC = ptC + ones(length(ptC(:,1)),1).*X; %column of ones times the position
end

function outPtC = reprojectImage(Image, Depth)
    S = size(Image);
    [Xi, Yi] = meshgrid(1:1:S(2)+4, 1:1:S(1));
    Z = 0.52*718./Depth(:);
    X =  (Xi(:)-1241/2).*Z/718;
    Y = (Yi(:)-376/2).*Z/718;
    A = [X, Y,Z];
    %remove bad points
    A((isnan(X) + isnan(Y) + isnan(Z))>0, :) = 0;
    A(((abs(Z)>20) + (abs(X) > 20) + (abs(Y) > 20)) > 0, :) = 0;
    %disp(sum(A(:) == Inf));
    outPtC = A;
end