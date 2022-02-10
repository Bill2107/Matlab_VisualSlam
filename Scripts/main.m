run('Layer0_DataCollection_Setup\SetupSequence.m');

for k = 2:kBig/ScalingValue
    frame = (k-1)*ScalingValue;
    run('Layer0_DataCollection_Setup\SetupFrame.m');
    n = 5;
    m = 10;
    R = ceil(length(Images{1,1}(1,:))/10);
    run('Layer1_Processing\FeatureTracking.m');
    run('Layer1_Processing\DepthMapGeneration.m');
    if(length(MP{1})> 5)
        run('Layer2_PointCloudGeneration\PointCloudGeneration.m');
        run('Layer3_CameraTransfrom\DetermineCameraTransfrom.m');
    else
        X = [0.01,0];
        disp('hello!');
    end
    run('Layer4_UpdateRobot\UpdateRobot.m');
    run('Layer5_Mapping\UpdateMap.m');
    %show(Omap)
  %  disp(ptCloud.Count);
%    pcshow(ptCloud);
%    pause(0.01);
 %   run('Layer4_UpdateRobot\plotRobot.m');
 %   run('Layer4_UpdateRobot\plotGroundTruth.m');
 %   run('Layer4_UpdateRobot\WriteToVideo.m');
    disp(k)
end
run("Layer6_ClearProgram\EndProgram.m");