

clc; clear all; close all;
load I11.txt; load I22.txt;
m1 = I11; m2 = I22;
I1 = imread('IMG_1020.JPG');
I2 = imread('IMG_1021.JPG');

s = length(m1);
m1=[m1(:,1) m1(:,2) ones(s,1)];
m2=[m2(:,1) m2(:,2) ones(s,1)];
Width = 4032; %image width
Height = 3024; %image height


load intrinsic_matrix.txt
K = intrinsic_matrix;


N=[2/Width 0 -1;
    0 2/Height -1;
    0   0   1];


x1=N*m1'; x2=N*m2';
x1=[x1(1,:)' x1(2,:)'];  
x2=[x2(1,:)' x2(2,:)']; 


A=[x1(:,1).*x2(:,1) x1(:,2).*x2(:,1) x2(:,1) x1(:,1).*x2(:,2) x1(:,2).*x2(:,2) x2(:,2) x1(:,1) x1(:,2), ones(s,1)];

[U D V] = svd(A);
F=reshape(V(:,9), 3, 3)';

[U D V] = svd(F);
F=U*diag([D(1,1) D(2,2) 0])*V';

F = N'*F*N;

figure(1);
subplot(121); imshow(I1);
title('Epipolar Lines in First Image'); hold on;
plot(m1(:,1), m1(:,2), 'go')
epiLines = epipolarLine(F', m2(:,1:2));  % performing l = Transpose(F)*x'
pts = lineToBorderPoints(epiLines, size(I1));
line(pts(:, [1,3])', pts(:, [2,4])');


subplot(122); imshow(I2); title('Epipole Lines in Second Image'); hold on;
plot(m2(:,1), m2(:,2), 'ro')
epiLines1 = epipolarLine(F, m1(:,1:2)); % performing l' = F*x{1}
pts = lineToBorderPoints(epiLines1, size(I2));
line(pts(:, [1,3])', pts(:, [2,4])');
truesize;


e1 = null(F);
e2 = null(F');




E=K'*F*K;

P4 = get4possibleP(E);
inX = [m1(1,:)' m2(1,:)'];
P1 = [eye(3) zeros(3,1)];
P2 = getCorrectCameraMatrix(P4, K, K, inX);

Xw = Triangulation(x1',K*P1, x2',K*P2);

x_new=Xw(1,:);
y_new=Xw(2,:);
z_new=Xw(3,:);

figure(2);
plot3(x_new, y_new, z_new,'r+');


