% [ny, nx, nz] =size(c);
% ind_num=max(max(max(c)));
% ind_pix = zeros(1, ind_num);
% for i = 1:ind_num
%     ind = find(c==i);
%     ind_pix(i) = length(ind);
% end
% % figure; plot(1:ind_num, ind_pix,'*');
% 
% new_c =c;
% %% get rid of bkg.
% thereshold = 4*10^3;
% l = find(ind_pix>thereshold);
% for i=1:length(l)
%     ind = find(c==l(i));
%     new_c(ind) =0;
% end
% 
% %% get rid of noise
% ll = find(ind_pix<10);
% for i=1:length(ll)
%     ind = find(c==ll(i));
%     new_c(ind) =0;
% end
% 
% n = find(ind_pix<=thereshold & ind_pix>=10);
% nc = length(n);
% 
% % [ny, nx, nz] =size(c);
% c_4d = zeros(ny, nx, nz, nc);
% 
% intensity = zeros(nt, nc);
% 
% figure;
% for i =1:nc
%     temp = zeros(ny, nx, nz);
%     ind = find(c==n(i));
%     temp(ind ) = 1;
%     c_4d(:,:,:,i) =temp; 
% %     vis3d(temp);
%     
%     for j =1:nt
%         intensity(j,i) = mean(mean(mean(temp.*img_stack(:,:,3:15,j))));
%     end
% 
%     subplot(ceil(nc/2),2,i);
%     plot(intensity(:,i));
%     ylabel(n(i));
% end
% vis3d(new_c);

%% pick the index


n = [85 22 64 55 7 40 12 76 53];
neuron = {'Or35a'  'Or59a'  'Or45b'  'Or45a' 'Or74a'  'Or47a'  'Or13a'  'Or24a'  'Or42b'};
% cm = colorcube(length(n) +1);
cm = jet(9);

mask = zeros(ny,nx,nz);
for i=1:length(n)
    ind = find(c==n(i));
    mask(ind) =1;
end
c_pick = c.*mask;

% vis3d(c_pick);

intensity = zeros(nt, length(n));
figure;
for i =1:length(n)
    temp = zeros(ny, nx, nz);
    ind = find(c==n(i));
    temp(ind ) = 1;
    
    for j =1:nt
        intensity(j,i) = sum(sum(sum(temp.*img_stack(:,:,:,j))))./sum(sum(sum(temp)));
    end

%     subplot(length(n),1,i);
%     plot(intensity(:,i));
%     ylabel(n(i));
end

nm_intensity = intensity;
for i= 1:length(n)
    f0=min(intensity(:,i));
    nm_intensity(:,i)=(intensity(:,i)-f0)./f0;
    
    subplot(length(n),1,i);
    plot((1:293)*0.703, nm_intensity(:,i), 'color', cm(i,:));
    ylabel(neuron{i},'color', cm(i,:));
    axis tight
    a = axis;
%     axis([ a(1) a(2) 0 ceil(a(4))]);
    axis([ a(1) a(2) 0 5]);

end

%% z project c_pick, and visulaize it
mask_zproj = zeros(ny, nx);
for i= 1:ny
    for j =1:nx
        mask_zproj(i,j) = max(c_pick(i, j, :));
    end
end

img_mask = zeros(ny, nx, 3);
for i=1:length(n)
    [row,col] = find(mask_zproj == n(i));
    for j = 1:length(row)
        img_mask(row(j), col(j), :) = cm(i,:)';
    end
end






% %%
% n = [47 43 117 151];
% 
% filter = zeros(ny,nx,nz, length(n));
% 
% for i=1:length(n)
%     temp = zeros(ny,nx,nz);
%     ind = find(c==n(i));
%     temp(ind) = 1;
%     filter(:,:,:,i) = temp;
% end