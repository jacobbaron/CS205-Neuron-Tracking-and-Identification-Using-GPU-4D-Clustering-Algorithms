function [new_centers]=move_to_min_grad(img,v)
new_centers=v;
padded_img=padarray(img,[1,1,1]);
%compute gradient
grad=(padded_img(3:end,2:end-1,2:end-1)-...
    padded_img(1:end-2,2:end-1,2:end-1)).^2+...
    (padded_img(2:end-1,3:end,2:end-1)-...
    padded_img(2:end-1,1:end-2,2:end-1)).^2+...
    (padded_img(2:end-1,2:end-1,3:end)-...
    padded_img(2:end-1,2:end-1,1:end-2)).^2;
% if point started on edge, instead move one point in.
v(v==1)=2;
for jj=1:3
    v(v(:,jj)==size(img,jj),jj)=size(img,jj)-1;
end
%iterate over centers, find smallest gradient in 3x3x3 volume


for ii=1:length(v)
   search_range=grad(v(ii,1)-1:v(ii,1)+1,...
       v(ii,2)-1:v(ii,2)+1,(v(ii,3)-1:v(ii,3)+1));
   [i,j,k]=ind2sub(size(search_range),...
       find(search_range==min(min(min(search_range))),1));
    if i==1, i=i+1; end;
    if j==1, j=j+1; end;
    if k==1, k=k+1; end;
    if i==size(grad,1), i=i-1; end;
    if j==size(grad,2), j=j-1; end;
    if k==size(grad,3), k=k-1; end;
    new_centers(ii,:)=v(ii,:)+[i,j,k]-3;
end



end