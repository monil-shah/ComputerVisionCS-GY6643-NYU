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
%imagecoordinates collected by ginput


%{
% ix= [2.0630    
    2.2190    
    2.3990    
    2.6030    
    2.8070    
    3.0470    
    3.2990    
    3.5930    
    3.5810    
    3.2990    
    3.0410    
    2.8190    
    2.6030    
    2.3990    
    2.2310    
    2.0630    
    1.9490    
    1.7870    
    1.6370    
    1.4570  
    1.2470    
    1.0370    
    0.7970    
    0.5150    
    0.4970    
    0.7910    
    1.0430    
    1.2530    
    1.4630    
    1.6310    
    1.7930    
    1.9550    
    1.9490    
    1.7990    
    1.6370    
    1.4690    
    1.2770    
    1.0430    
    0.7910    
    0.5330    
    2.0630    
    2.2250    
    2.3990    
    2.6030    
    2.7950    
    3.0410    
    3.2930    
    3.5810    
    3.5690    
    3.2930    
    3.0290    
    2.8130    
    2.5850    
    2.4050    
    2.2310    
    2.0690    
    1.9550    
    1.7990    
    1.6550    
    1.4810    
]*1000;
iy= [2.4350
              2.4710
              2.5070
        2.5430
        2.5910
        2.6390
        2.6810
        2.7350
        2.4590
        2.4170
        2.3810
        2.3450
        2.3150
        2.2790
        2.2490
        2.2310
        2.2310
        2.2550
        2.2850
        2.3210
        2.3690
        2.4050
        2.4590
        2.5130
        2.7890
        2.7290
        2.6570
        2.6150
        2.5490
        2.5130
        2.4710
        2.4350
        2.0210
        2.0330
        2.0630
        2.0870
        2.1050
        2.1470
        2.1710
        2.2010
        2.0090
        2.0330
        2.0570
        2.0750
        2.0990
        2.1170
        2.1410
 %       2.1710
 %       1.8890
 %       1.8830
 %       1.8710
 %       1.8530
 %       1.8470
 %       1.8290
 %       1.8290
 %       1.8230
 %       1.8170
 %       1.8230
 %      1.8290
 %       1.8470]*1000; 
%}
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
 
 %extrinsic
 r1 = cross_a2a3/norm(cross_a2a3);
 r2 = cross(r3, r1);
 K = [alpha -1*alpha*cot(theta) u_0
      0 beta/sin(theta) v_0
      0 0 1];
 
 t = inv(K) * b; %translation vector
 
 %rotation matrix
 R(1,1:3) = r1;
 R(2,1:3) = r2;
 R(3,1:3) = r3;
 %%Test of calibration estimates: reconstruction error of 4 new points
 %image coordinates (measured)
 ix_test_measured = 1.0e+003 *[0.20750 0.22370 1.8230 1.9550];
 iy_test_measured = 1.0e+003 *[0.24230 0.24590 0.563 0.599];
 %world coordinates (measured)
 wx_test_measured = [0.9 0.9+2.8 0 0];
 wy_test_measured = [0 0 0.9 0.9+1*2.8];
 wz_test_measured = [0 0 9*2.8 9*2.8];
 %reconstruct image coordinates and calculate estimation error
 for i=1:4
    temp(1:4) = [wx_test_measured(i) wy_test_measured(i) wz_test_measured(i) 1];
    image_reconstructed = M * temp';
    image_reconstructed_x(i) = (image_reconstructed(1)/image_reconstructed(3));
    image_reconstructed_y(i) = (image_reconstructed(2)/image_reconstructed(3));
    error(i) = norm([image_reconstructed_x(i)-ix_test_measured(i) image_reconstructed_y(i)-iy_test_measured(i)]);
 end



  