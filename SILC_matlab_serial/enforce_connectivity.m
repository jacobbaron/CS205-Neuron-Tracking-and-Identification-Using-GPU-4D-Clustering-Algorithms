function [label,num_objects]=enforce_connectivity(label,Cijk)    
num_objects_old=inf(size(Cijk(:,1)))';
srange=1;
while (srange<=6)
    for ii=1:length(Cijk)
        cc=bwconncomp(label==ii);
        [cSize, I]=sort(cellfun(@length,cc.PixelIdxList),'descend');
        comp_size(ii)=cSize(1);
    end
    for ii=1:length(Cijk)
        %% 
        %find connected components for given superpixel
        cc=bwconncomp(label==ii);
        num_objects(ii)=cc.NumObjects;

        [cSize, I]=sort(cellfun(@length,cc.PixelIdxList),'descend');
        if cc.NumObjects>1

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
                [~,I_dist]=sort(dist);
                %search through the 3 closest clusters
                [~,I_large]=max(comp_size(I_dist(1:srange)));
                label(pts_to_assign(jj))=I_dist(I_large);
            end
        end
    end
    num_objects_new=num_objects;
    if all(num_objects_old==num_objects_new)
        srange=srange+1;
    end    
    num_objects_old=num_objects_new;
end
