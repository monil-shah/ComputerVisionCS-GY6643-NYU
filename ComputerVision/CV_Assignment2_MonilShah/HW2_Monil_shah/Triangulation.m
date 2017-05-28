
function Xw = Triangulation(x1,P1,x2,P2)


x11 = x1; 
x22 = x2; 


for i=1:size(x11,2)
    sx1 = x11(:,i);
    sx2 = x22(:,i);
    
    
    A1 = sx1(1,1).*P1(3,:) - P1(1,:);
    A2 = sx1(2,1).*P1(3,:) - P1(2,:);
    A3 = sx2(1,1).*P2(3,:) - P2(1,:);
    A4 = sx2(2,1).*P2(3,:) - P2(2,:);
    
    A = [A1;A2;A3;A4];
    [U,D,V] = svd(A);
    
    X_temp = V(:,4);
    X_temp = X_temp ./ repmat(X_temp(4,1),4,1);
    
    Xw(:,i) = X_temp;
    
end


   
   
