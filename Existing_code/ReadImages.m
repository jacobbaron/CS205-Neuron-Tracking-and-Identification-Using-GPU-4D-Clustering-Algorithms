% %% 2D
% fname = 'fn.tif';
% info = imfinfo(fname);
% num_images = numel(info);
% ny=info(1).Width;
% nx=info(1).Height;
% img_stack=zeros(ny, nx ,num_images);
% for k = 1:num_images
%     A = imread(fname, k);
%     img_stack(:,:,k)= A;
% end
% 
% img_mean = mean(img_stack, 3);
% nm_img_stack = img_stack;
% for k = 1:num_images
%     nm_img_stack(:,:,k)= (img_stack(:,:,k)-img_mean)./img_mean;
% end


% 
% c=Kmean_xyt3(newImg, 40, 100, 10, 0);
% imagesc(c);
% 
% 
% id = 1:10;
% % id = 12;
% np = length(id);
% figure;
% 
% for i =1: np
%     ind = find(c== id(i));
% 
%     intensity = zeros(1, num_images);
%     for k = 1:num_images
%         temp = img_stack(:,:,k);
%         intensity(k) = mean(temp(ind));
%     end
%     
%     subplot(np,1,i);
%     plot(intensity);
%     ylabel(id(i))
% end

%% 3D

%% read from multiple stack figures.
%mydir = '.\Movie_Stacks\';
Files = dir('*.tif');
nz = length(Files);
info = imfinfo(Files(1).name);
nt = numel(info);
ny=info(1).Width;
nx=info(1).Height;

red_img_stack = zeros(ny,nx,nz,nt);

%poolobj = parpool('local',4);
parfor i = 1:nz;
    i
    fname = Files(i).name;
    for j=1:nt
        j
        A = imread(fname, j);
        red_img_stack(:,:,i,j)=A;
    end    
end
%delete(poolobj);

img_mean = mean(red_img_stack, 4);
nm_img_stack = red_img_stack;
for k = 1:nt
    k
    nm_img_stack(:,:,:,k)= (red_img_stack(:,:,:,k)-img_mean)./img_mean;
end

