figure(1);
hold on;
if k > 1
    plot(Robot{k,2}(1), Robot{k,2}(3), '.' ,'Color','Blue');
    plot(Robot{k-1,2}(1), Robot{k-1,2}(3), '.' ,'Color','Red');
end
axis equal;
title('odometry');
set(gcf,'position', [100 200 1280 720 ]);
if(k >3)
    frame =  getframe(gcf) ;
    writeVideo(v,frame);
end