
function [P] = getCorrectCameraMatrix(PXcam, K1,K2, X)
    x = X(:,1);
    xp = X(:,2);
    Pcam = [eye(3),zeros(3,1)];
    P = K1*Pcam;
    xhat = inv(K1)*x;
    X3D = zeros(4,4);
    Depth = zeros(4,2);
    for i=1:4
        xphat = inv(K2)*xp;
        A = [Pcam(3,:).*xhat(1,1)-Pcam(1,:);
             Pcam(3,:).*xhat(2,1)-Pcam(2,:);
             PXcam(3,:,i).*xphat(1,1)-PXcam(1,:,i);
             PXcam(3,:,i).*xphat(2,1)-PXcam(2,:,i)];
        A1n = sqrt(sum(A(1,:).*A(1,:)));
        A2n = sqrt(sum(A(2,:).*A(2,:)));
        A3n = sqrt(sum(A(1,:).*A(1,:)));
        A4n = sqrt(sum(A(1,:).*A(1,:))); 
        Anorm = [A(1,:)/A1n;
                 A(2,:)/A2n;
                 A(3,:)/A3n;
                 A(4,:)/A4n];
        [Uan,San,Van] = svd(Anorm);
        X3D(:,i) = Van(:,end);
        xi = PXcam(:,:,i)*X3D(:,i);
        w = xi(3);
        T = X3D(end,i);
        m3n = sqrt(sum(PXcam(3,1:3,i).*PXcam(3,1:3,i)));
        Depth(i,1) = (sign(det(PXcam(:,1:3,i)))*w)/(T*m3n);
        xi = Pcam(:,:)*X3D(:,i);
        w = xi(3);
        T = X3D(end,i);
        m3n = sqrt(sum(Pcam(3,1:3).*Pcam(3,1:3)));
        Depth(i,2) = (sign(det(Pcam(:,1:3)))*w)/(T*m3n);       
    end;
    if(Depth(1,1)>0 && Depth(1,2)>0)
        P = PXcam(:,:,1);
    elseif(Depth(2,1)>0 && Depth(2,2)>0)
        P = PXcam(:,:,2);    
    elseif(Depth(3,1)>0 && Depth(3,2)>0)
        P = PXcam(:,:,3);
    elseif(Depth(4,1)>0 && Depth(4,2)>0)
        P = PXcam(:,:,4);
    end;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    