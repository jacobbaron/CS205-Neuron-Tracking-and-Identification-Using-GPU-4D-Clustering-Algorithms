function [nm_img_stack]=normalize_t(img_stack,n)
    close all;
    sz=size(img_stack);
    l=sqrt(sum(img_stack.^2,4));
    lrep=repmat(l,1,1,1,sz(4));
    nm_img_stack=img_stack./(lrep+n);

end