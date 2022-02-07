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