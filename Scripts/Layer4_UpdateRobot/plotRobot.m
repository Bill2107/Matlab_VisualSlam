figure(1);
hold on;
for i = 1:k
    plot(Robot{i,2}(1), Robot{i,2}(3), '.' ,'Color','red');
end
plot(Robot{k,2}(1), Robot{k,2}(3), '.' ,'Color','Blue');
axis equal;
title('odometry');
set(gcf,'position', [100 200 1280 720 ]);
if(k >3)
    frame =  getframe(gcf) ;
    writeVideo(v,frame);
end