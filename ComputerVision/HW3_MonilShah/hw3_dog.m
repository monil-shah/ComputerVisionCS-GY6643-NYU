I1=imread('dog1.png');
I2=imread('dog2.png');
I3=imread('dog3.png');
I4=imread('dog4.png');
images = zeros(size(I1,1),size(I1,2));
for i = 1:size(I1,1)
for j = 1:size(I1,2)
images(i,j,1) = I1(i,j);
images(i,j,2) = I2(i,j);
images(i,j,3) = I3(i,j);
images(i,j,4) = I4(i,j);
end
end
% Initializations
albedo=zeros(size(I1,1),size(I1,2));
p = zeros(size(I1,1),size(I1,2));
q = zeros(size(I1,1),size(I1,2));
normal_vector = zeros(size(I1,1), size(I1,2),1);
for i = 1:size(I1,1)
for j = 1:size(I1,1)
normal_vector(i,j,1) = 0;
normal_vector(i,j,2) = 0;
normal_vector(i,j,3) = 0;
end
end
%L=[0,0,1;0.2,0,1;-0.2,0,1;0,0.2,1]; %position of light source
L=[-16,-19,30;-13,-16,30;17,-10.5,26.5;-9,25,4];
L=normr(L);
%L=[-0.38359,-0.236647,0.89266;-0.372825,0.303914,0.87672;0.250814,0.34752,0.903505;0.203844,-0.096308,0.974255]
%L=[-16,-19,30;-13,-16,30;17,-10.5,26.5;-9,25,4];
normal=[0;0;0];
% processing
for i = 1:size(I1,1)
for j = 1:size(I1,2)
I(1) = double(images(i,j,2))/255;
I(2) = double(images(i,j,2))/255;
I(3) = double(images(i,j,3))/255;
I(4) = double(images(i,j,4))/255;
%I(4) = double(images(i,j,4))/255;

   
%{
if(images(i,j,1)~=0)
I(1) = double(images(i,j,1));
end
if(images(i,j,2)~=0)
I(2) = double(images(i,j,2));
end
if(images(i,j,3)~=0)
I(3) = double(images(i,j,3));
end
if(images(i,j,4)~=0)
I(4) = double(images(i,j,4));
end
%}
if(I(1)~=0 && I(2)~=0 && I(3)~=0 && I(4) ~=0 )
A = L'*L;
b = L'*I';
g = inv(A)*b;
albedo(i,j) = norm(g);
normal = g/albedo(i,j);
normal_vector(i,j,1) = normal(1);
normal_vector(i,j,2) = normal(2);
normal_vector(i,j,3) = normal(3);
p(i,j) = normal(1)/normal(3);
q(i,j) = normal(2)/normal(3);
end
end
end

maxalbedo = max(max(albedo) );
if( maxalbedo > 0)
albedo = albedo/maxalbedo;
end

depth=ones(size(I1,1));
for i = 2:size(I1,1)
for j = 2:size(I1,1)
depth(i,j) = depth(i-1,j-1)+q(i,j)+p(i,j);
%depth(i,j) = depth(i-1,j-1)+frankotcheplla(p(i,j),q(i,j));
end
end
%depth = frankotcheplla(p,q);
[offset,indice] = min(depth(:));
depth = depth+(-offset);

%depth = Function(p,q);
%figure(5)
%{
for i = 2:size(I1,1)
for j = 2:size(I1,1)
plot3(j+normal_vector(i,j,1),i+normal_vector(i,j,2),normal_vector(i,j,3),'b' );
end
end
%}
[ X, Y ] = meshgrid( 1:size(I1,1), 1:size(I1,1) );
figure(2);
surf(X,Y,depth,'EdgeColor','none');
camlight left;
lighting phong
figure(3);
mesh(X,Y,depth);
figure(4);
spacing = 4;
[x,y] = meshgrid(1:spacing:size(I1,1), 1:spacing:size(I1,2));
quiver(-x,-y,p(1:spacing:end, 1:spacing:end),q(1:spacing:end, 1:spacing:end));
axis tight;
axis square;
figure(1);
imshow(albedo);
%display estimated surface
%figure(1);
%surfl(depth);
%colormap(gray);
%grid off;
%shading interp