%FigHandle = figure('Position', [100, 100, 1300, 450]);
%subplot(1,2,1)
%={'red','green','blue','magenta','black','yellow'};
col=hsv(num_disp_clusters);
for ii=1:num_disp_clusters
    hpatch(ii)=patch(isosurface(label.*(label==Idx(ii)),0));
    isonormals(label.*(label==Idx(ii)),hpatch(ii));
    hpatch(ii).FaceColor = col(ii,:);
    hpatch(ii).EdgeColor = 'none';
    hold on;
    
end
    axis off 
    daspect([1,1,1])
    view([183,-90]);
    camlight('right') 
    lighting gouraud
    %im=imagesc(red_img_avg(:,:,7))
    %
    legend(mat2cell(num2str(Idx(1:num_disp_clusters)'),num_disp_clusters))
    %title('Highest Intensity Clusters')
    
   % subplot(1,2,2)
    im=surf([1 120],[1 120],repmat(10,[2 2]),max(red_img_avg,[],3),'facecolor','texture');
    axis equal;
    colormap(hot)
    alpha(im,.6);
    figure
    for  ii=1:num_disp_clusters
        subplot(num_disp_clusters,1,ii)
        label_idx=repmat(label==Idx(ii),1,1,1,size(img_stack,4));
        img_label=img_stack.*label_idx;
        img_label(img_label==0)=NaN;
        plot(reshape(nanmean(nanmean(nanmean(img_label,1),2),3),[],1),'Color',col(ii,:));
        
    end