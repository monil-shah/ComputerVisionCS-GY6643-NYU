load I1.txt
load I2.txt
m1 = I1;
m2 = I2;
 
figure(1); 
subplot(121);
im1 = imread('IMG_1028.JPG');
imshow(im1);title('stereo Image pair 1 left image');
hold on;
plot(m1(:,1), m1(:,2), 'R+', 'LineWidth', 2, 'MarkerSize',10);
hold off;


subplot(122);
im2 = imread('IMG_1029.JPG');
imshow(im2);title('stereo Image pair 1 right image');
hold on;
plot(m2(:,1), m2(:,2), 'R+', 'LineWidth', 2, 'MarkerSize',10);
hold off;
