for iI = 1:1
    [H, W] = size(Images{1,iI});
    
    x = 1:(W-1)/m:W;
    y = 1:(H-1)/n:H;
    
    P = [];
    for i = 1:(length(x)-1)
        for j = 1:(length(y)-1)
            regionOfInterest = [x(i), y(j), (W-1)/m, (H-1)/n];
            orbP = detectFASTFeatures(Images{1,iI}, ... %'MinQuality', 0.00, ...
                ...%'MinContrast', 0.1, ...
                'ROI',regionOfInterest).selectStrongest(PointsPerBucket);
                
            if orbP.Count < 500
                %disp(orbP.Count)
            end
         %   [features,points] = extractFeatures(I,orbP);
            %Add to list
            P = [P; orbP.Location];
        end
    end
    points = cornerPoints(P);
    clear H W P x y
end

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,points.Location,Images{1,1});
[points2,validity] = tracker(Images{1,2});
points2 = cornerPoints(points2(validity,:));
MP{1} = points(validity,:);
MP{2} = points2;

%figure(1)
%plot(MP{1}.Location(:,1), MP{1}.Location(:,2), 'o', 'Color', 'red');
%hold on
%for i = 1:length(MP{1}.Location(:,1))
%    plot([MP{1}.Location(i,1), MP{2}.Location(i,1)], [MP{1}.Location(i,2), MP{2}.Location(i,2)], '-', 'Color', 'green');
%end
%xlim([0 1226])
%ylim([0 370])
%hold off