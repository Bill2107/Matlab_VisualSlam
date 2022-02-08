dZ = 0.01;
dW = 0;
x0 = [dZ, dW];
if(length(PointCloud{1}) < MinPointsPerCloud)
    disp(sprintf('Error: Too few Points %d < %d', length(PointCloud{1}), MinPointsPerCloud));
end
fun = @(x)Minimisation(x,PointCloud{1}, PointCloud{2});
X = fminsearch(fun,x0);
if(X(1)>0.03)
    X(1) = 0.02
end

function diff = Minimisation(x0, PC1, PC2)
    PCp = applyMove2Cloud(x0(1), x0(2),PC1);
    a = (PCp(:,1)-PC2(:,1));
    b = (PCp(:,2)-PC2(:,2));
    c = (PCp(:,3)-PC2(:,3));
    diff = (a'*a + b'*b + (c'*c));
end

function PC = applyMove2Cloud(Dz,Dw, PC)%Du, Dw, pList)
    for i = 1:length(PC(:,1))
        X = PC(i,1);
        Y = PC(i,2);
        Z = PC(i,3);
        %ROTATE
        angle1 = atan2(X,Z);
        angle2 = angle1 + Dw;
        R = norm([X,0,Z],2);
        newZ = R*cos(angle2);
        newX = R*sin(angle2);
        %TRANSLATE
        newZ = newZ - Dz;
        newY = Y; % height shouldnt change
        PC(i,:) = [newX, newY, newZ];
    end 
end
