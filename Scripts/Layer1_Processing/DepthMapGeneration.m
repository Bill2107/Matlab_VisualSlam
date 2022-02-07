disparityMap{1} = disparitySGM(Images{1,1},Images{2,1}, 'DisparityRange', [0 10*8]);
disparityMap{2} = disparitySGM(Images{1,2},Images{2,2}, "DisparityRange", [0 10*8]);

S = size(disparityMap{1});

