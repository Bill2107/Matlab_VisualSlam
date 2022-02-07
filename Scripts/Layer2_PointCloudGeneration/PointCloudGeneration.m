%% Point Cloud Generation
% Now that we have a set of matched points and a set of depth clouds for T
% and T-1 we can construct a point cloud.

%% Assign InterpolatedDM to each point
%for each point , if INTDM Exists do thing
PointsList{2}(1, 1:3) = 0; 
for j = 1:2
    count = 1;
    for i = 1:length(MP{j}.Location(:,1))
        coords = MP{j}.Location(i,:);
        coords = floor(coords);
        D = InterpolatedDM{j}(coords(2),coords(1));
        if ~isnan(D)
            PointsList{j}(count,3) = InterpolatedDM{j}(coords(2),coords(1)).*100;
            PointsList{j}(count,1:2) = coords;
            count = count + 1;
        else
            PointsList{j}(count,3) = 999999999;
            PointsList{j}(count,1:2) = coords;
            count = count + 1;
        end
    end
end
%% Actually Construct the Cloud
PointCloud{1} = zeros(size(PointsList{1}));
PointCloud{2} = zeros(size(PointsList{2}));
for j = 1:2
    for i = 1: length(PointsList{j}(:,1))
      % A = [PointsList(i,1), PointsList(i,2),PointsList(i,3),1]*Q;
      % A = A./A(1,4);
      Z = 0.52*718./PointsList{j}(i,3);
      X =  (PointsList{j}(i,1)-1241/2)*Z/718;
      Y = (PointsList{j}(i,2)-376/2)*Z/718;
        A = [X, Y,Z];
        PointCloud{j}(i,:) = A(1:3);
       
     %  plot3(A(1), A(2), A*(3));
    end
end
%%  Remove stuff thats bad because its too far away
for i=1:length(PointCloud{1}(:,1))
    if norm(PointCloud{1}(i,3)) >1 ||  norm(PointCloud{2}(i,3)) >1
        if i == 1
        else 
        PointCloud{1}(i,:) = PointCloud{1}(i-1,:);
        PointCloud{2}(i,:) = PointCloud{2}(i-1,:);
        end
    end
end

clear X Y Z PointsList j i D count coords A