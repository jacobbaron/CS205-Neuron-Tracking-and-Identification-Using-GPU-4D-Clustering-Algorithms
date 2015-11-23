function [grad]=move_to_min_grad(img,v)

grad=padarray(abs(gradient(img)),[1,1,1],'replicate');
v = v + 1;
grad_centers=grad(v(:,1),v(:,2),v(:,3));
for ii=1:length(v)
   search_range=grad(v(ii,1)-1:v(ii,1)+1,...
       v(ii,2)-1:v(ii,2)+1,(v(ii,3)-1:v(ii,3)+1));
   [i,j,k]=ind2sub(size(search_range),...
       find(search_range==min(min(min(search_range))),1));
    if i==1, i=i+1; end;
    if j==1, j=j+1; end;
    if k==1, k=k+1; end;
    if i==length(grad,1), i=i-1; end;
    if j==length(grad,2), j=j-1; end;
    if k==length(grad,3), k=k-1; end;
    v(ii,:)=[i,j,k]-1;
end



end