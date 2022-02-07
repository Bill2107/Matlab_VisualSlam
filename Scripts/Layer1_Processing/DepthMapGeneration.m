disparityMap{1} = disparitySGM(Images{1,1},Images{2,1}, 'DisparityRange', [0 10*8]);
disparityMap{2} = disparitySGM(Images{1,2},Images{2,2}, "DisparityRange", [0 10*8]);

%% Step 1 Pool the disparity Map
%This is effectively a resize operation
disparityMap{1} = imresize(disparityMap{1},0.2,'nearest');
disparityMap{2} = imresize(disparityMap{2},0.2,'nearest');
%% Step 2 interpolate the pooled map
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

%% Step 3 Resize back to normal
InterpolatedDM{1} = imresize(InterpolatedDM{1},1/0.2,'nearest');
InterpolatedDM{2} = imresize(InterpolatedDM{2},1/0.2,'nearest');
%note the resize wont be perfect since the prime factorisations of 1241
%and 376 dont share common factors but it will only ever end up being a
%couple pixels off so its probably ok

%imshow(InterpolatedDM{1}, [0, 10*8]);
%colormap jet;
%colorbar;
%title('Fast Interpolation with pooling to 20%')
clear j disparityMap S xi x yi y DM