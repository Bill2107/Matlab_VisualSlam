run('Layer0_DataCollection_Setup\SetupSequence.m');
for k = 2:kBig
    tic
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
        X = [0,0];
    end
    run('Layer4_UpdateRobot\UpdateRobot.m');
    run('Layer4_UpdateRobot\plotRobot.m');
    disp(k)
    toc
end
run("Layer5_ClearProgram\EndProgram.m");