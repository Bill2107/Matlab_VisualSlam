run('Layer0_DataCollection_Setup\SetupSequence.m');
for k = 1:kBig
    run('Layer0_DataCollection_Setup\SetupFrame.m');
    imshow(Images{1,1});
end