function [label_filtered]=find_plot_top_n_clusters(tot_num_clusters,img_stack,label,red_img_avg,num_disp_clusters)
for ii=1:tot_num_clusters
    mean_sig(ii)=mean(red_img_avg(label==ii));
end
[~, Idx]=sort(mean_sig,'descend');
label_filtered=label.*(ismember(label,Idx(1:num_disp_clusters)));
%new_label=find_disjoined_pixels(label);
plot_3d_stuff;
