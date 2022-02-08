Images{1,1} = imread(sprintf('%s/image_0/%06d.png', SEQ_PATH, frame));
Images{2,1} = imread(sprintf('%s/image_1/%06d.png', SEQ_PATH, frame));
Images{1,2} = imread(sprintf('%s/image_0/%06d.png', SEQ_PATH, frame+1));
Images{2,2} = imread(sprintf('%s/image_1/%06d.png', SEQ_PATH, frame+1));

Images{1,1} = undistortImage(Images{1,1},cameraParams{1});
Images{2,1} = undistortImage(Images{2,1},cameraParams{2});
Images{1,2} = undistortImage(Images{1,2},cameraParams{1});
Images{2,2} = undistortImage(Images{2,2},cameraParams{2});
