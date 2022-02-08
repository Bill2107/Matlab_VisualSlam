X = X.*[LengthScaling,1]; 
if(X(1) > 0) % dont want huge changes in heading
    Robot{k, 1} = Robot{k-1,1} + X(2);
    a = Robot{k-1,1};
    Robot{k, 2} = Robot{k-1, 2} + [sin(a), 0, cos(a)].*X(1);
else
    Robot{k, 1} = Robot{k-1,1} + X(2);
    a = Robot{k-1,1};
    Robot{k,2} = Robot{k-1,2} + [sin(a), 0, cos(a)].*[0,0,0.01];
end