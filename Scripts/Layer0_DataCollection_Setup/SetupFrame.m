Images{1,1} = imread(sprintf('%s/image_0/%06d.png', SEQ_PATH, k));
Images{2,1} = imread(sprintf('%s/image_1/%06d.png', SEQ_PATH, k));
Images{1,2} = imread(sprintf('%s/image_0/%06d.png', SEQ_PATH, k+1));
Images{2,2} = imread(sprintf('%s/image_1/%06d.png', SEQ_PATH, k+1));
