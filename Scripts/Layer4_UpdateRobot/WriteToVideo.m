set(gcf,'position', [100 200 1280 720 ]);
if(k >3)
    frame =  getframe(gcf) ;
    writeVideo(v,frame);
end