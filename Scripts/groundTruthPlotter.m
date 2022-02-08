hold on
for k = 1:2000
x = L(k,4);
y = L(k,4*2);
z = L(k,4*3);
plot(x,z,'.','Color','Green');
disp(k);
pause(0.01);
end