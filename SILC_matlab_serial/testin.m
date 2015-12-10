%enfore connectivity
for ii=1:length(Cijk)
    %% 
    cc=bwconncomp(label==ii);
    if cc.NumObjects>1
        [ccSize I]=sort(cellfun(@length,cc.PixelIdxList),'descend');
        %reassign disconnected components to nearest cluster
        pts_to_assign=cell2mat(cellfun(@transpose,cc.PixelIdxList(I(2:end)),...
            'UniformOutput',false))';
        for jj=1:length(pts_to_assign)
            [i,j,k]=ind2sub(size(label),pts_to_assign(jj));
            i=i*ones(size(Cijk(:,1)));
            j=j*ones(size(Cijk(:,1)));
            k=k*ones(size(Cijk(:,1)));
            dist=sqrt((Cijk(:,1)-i).^2+(Cijk(:,2)-j).^2+...
                (Cijk(:,3)-k).^2);
            [~,I]=min(dist);
            label(pts_to_assign(jj))=I;
        end
    end
end