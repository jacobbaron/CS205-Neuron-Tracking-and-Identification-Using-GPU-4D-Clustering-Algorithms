figure;
col={'red','green','blue','magenta','black','yellow'};
for ii=1:6
    hpatch(ii)=patch(isosurface(label.*(label==Idx(ii)),0));
    isonormals(label.*(label==Idx(ii)),hpatch(ii));
    hpatch(ii).FaceColor = col{ii};
    hpatch(ii).EdgeColor = 'none';
    hold on;
end

    daspect([1,1,1])
    view(3); axis tight
    camlight 
    lighting gouraud