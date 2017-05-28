%worldcoordinates=w
wz(1:6) = 7*2.8;
wz(7:12) = 6*2.8;
wz(13:18) = 5*2.8;
wz(19:24) = 4*2.8;
wz(25:30) = 3*2.8;
wz(31:36) = 7*2.8;
wz(37:42) = 6*2.8;
wz(43:48) = 5*2.8;
wz(49:55) = 4*2.8;
wz(55:60) = 3*2.8;
wx(1:60)=0
wx(1:6:30)=0.9+6*2.8;
wx(2:6:30)=0.9+5*2.8;
wx(3:6:30)=0.9+4*2.8;
wx(4:6:30)=0.9+3*2.8;
wx(5:6:30)=0.9+2*2.8;
wx(6:6:30)=0.9+1*2.8;
wy(1:60)=0
wy(31:6:60)= 0.9+1*2.8;
wy(32:6:60)= 0.9+2*2.8;
wy(33:6:60)= 0.9+3*2.8;
wy(34:6:60)= 0.9+4*2.8;
wy(35:6:60)= 0.9+5*2.8;
wy(36:6:60)= 0.9+6*2.8;

%image coordinates
A = imread('IMG_0919.JPG');
A = rgb2gray(A);
imshow(A);

ix = x;
iy = y;

n=60;
 P(1:2*n,1:12)=0;
 j=1;
 for i=1:2:120
     P(i,1)=wx(j);
     P(i,2)=wy(j);
     P(i,3)=wz(j);
     P(i,4)=1;
     P(i+1,5)=wx(j);
     P(i+1,6)=wy(j);
     P(i+1,7)=wz(j);
     P(i+1,8)=1;
     P(i,9:12)=P(i,1:4)*-1*ix(j);
     P(i+1,9:12)=P(i,1:4)*-1*iy(j);
     j=j+1;
 end
 [U,S,V]= svd(P);
 [min_val,min_index]=min(diag(S(1:12,1:12)));
 m=V(1:12,min_index);
 norm_31 = norm(m(9:11));
 m_canonical = m / norm_31;
 M(1,1:4) = m_canonical(1:4);
 M(2,1:4) = m_canonical(5:8);
 M(3,1:4) = m_canonical(9:12);
 a1 = M(1,1:3);
 a2 = M(2,1:3);
 a3 = M(3,1:3);
 b = M(1:3,4);
 r3 = a3;
 
 %intrinsic
 u_0 = a1*a3';
 v_0 = a2*a3';
 cross_a1a3 = cross(a1,a3);
 cross_a2a3 = cross(a2,a3);
 theta = acos (-1*cross_a1a3*cross_a2a3'/(norm(cross_a1a3)*norm(cross_a2a3)));
 alpha = norm(cross_a1a3) * sin(theta);
 beta = norm(cross_a2a3) * sin(theta);