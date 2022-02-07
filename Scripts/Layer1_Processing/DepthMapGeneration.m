disparityMap{1} = disparitySGM(Images{1,1},Images{2,1}, 'DisparityRange', [0 10*8]);
disparityMap{2} = disparitySGM(Images{1,2},Images{2,2}, "DisparityRange", [0 10*8]);

S = size(disparityMap{1});

for j = 1:2
    [xi,yi] = meshgrid( 1:1:S(2), 1:1:S(1));
    [x,y] = meshgrid(1:1:S(2), 1:1:S(1));
    x = x.*(~isnan(disparityMap{j}));
    y = y.*(~isnan(disparityMap{j}));
    DM = disparityMap{j};
    %DM(isnan(DM)) = 0;
   % InterpolatedDM{j} = scatteredInterpolant(x(:),y(:),double(DM(:)));
    InterpolatedDM{j} = griddata(x,y,double(DM),xi,yi);
  %  InterpolatedDM{j} = imfill(disparityMap{j},8);
end