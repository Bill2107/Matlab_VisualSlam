run('Layer0_DataCollection_Setup\SetupSequence.m');
for k = 1:kBig
    run('Layer0_DataCollection_Setup\SetupFrame.m');
    n = 5;
    m = 10;
    R = ceil(length(Images{1,1}(1,:))/10);
    run('Layer1_Processing\FeatureTracking.m');
    run('Layer1_Processing\DepthMapGeneration.m');
        imshow(InterpolatedDM{1}, [0, 10*8]);
        colormap jet
        colorbar
end