%the map is a point cloud with [0,0,0] being the robots starting position
if k > 2
    ptCloud = pointCloud([ptCloud.Location; ...
        applymove2PC(PointCloud{1,2}, Robot{k,2}, Robot{k,1})]);
else %create the Map
    ptCloud = pointCloud(PointCloud{1,2});
end

function outPtC = applymove2PC(ptC, X, w)
        angle1 = atan2(ptC(1),ptC(3));
        angle2 = angle1 - w;
        R = norm([ptC(1),0,ptC(3)],2);
        ptC(1) = R*cos(angle2);
        ptC(3) = R*sin(angle2);
        outPtC = ptC + ones(length(ptC(:,1)),1).*X; %column of ones times the position
end