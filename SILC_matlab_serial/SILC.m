tic
num_clusters=100;
f=4;
if ~exist('img_stack')
    load('aligned_xyzt_data')
    load('red_img_stack')
end

%% 
nm_img_stack=normalize_t(img_stack,0);

red_img_avg=mean(red_img_stack,4);
scale_Ir=1/max(max(max(red_img_avg)));

Li=size(nm_img_stack,1);
Lj=size(nm_img_stack,2);
Lk=size(nm_img_stack,3);
Lt=size(nm_img_stack,4);
scale_ijk=1/sqrt(Li^2+Lj^2+Lk^2);
%S_z=S_xy/10, sz_x/S_xy+sz_y/S_xy+sz_z/S_z=num_clusters
%
%[gx,gy,gz]=meshgrid(linspace(1,Lx,round(Nxy)),linspace(1,Ly,round(Nxy)),...
%    linspace(1,Lz,round(Nz)));
nm_img_stack_listed=reshape(nm_img_stack,[],Lt);

[Cijk,Sij,Sk]=generate_clusters(num_clusters,Li,Lj,Lk,f);
%store center vectors [i,j,k,I_r,I_g[t1],I_g[t2]...I_g[tn]]
center_idx=sub2ind(size(red_img_avg),Cijk(:,1),Cijk(:,2),Cijk(:,3));
CijkRG=[Cijk,red_img_avg(center_idx),nm_img_stack_listed(center_idx,:)];
label=-1*ones(size(red_img_avg));
dist=Inf(size(red_img_avg));

%Cxyz=move_to_min_grad(red_img_avg,Cxyz);
nm_img_stack_listed=reshape(nm_img_stack,[],Lt);
%% 
%begin iterating!
%this 
Err=inf(size(CijkRG(:,1)));
for iter=1:10 %some condition to be determined later

%Assign the best matching pixels from a 2S_xy � 2S_xy x 2S_z cubic
%neighborhood around the cluster center according to the distance measure
%% 
    for ii=1:length(Cijk)
        %range i,j,k are the search range
        range_i=remove_out_of_bounds(Cijk(ii,1)-Sij:Cijk(ii,1)+Sij,0,Li);
        range_j=remove_out_of_bounds(Cijk(ii,2)-Sij:Cijk(ii,2)+Sij,0,Lj);
        range_k=remove_out_of_bounds(Cijk(ii,3)-Sk:Cijk(ii,3)+Sk,0,Lk);
        [ig,jg,kg]=meshgrid(range_j,range_i,range_k);

                                            %compute distance
        d=compute_distance(scale_ijk,scale_Ir,...
            ig,jg,kg,...
            nm_img_stack(range_i,range_j,range_k,:),...
            red_img_avg(range_i,range_j,range_k),...
            Cijk(ii,:),nm_img_stack(Cijk(ii,1),Cijk(ii,2),Cijk(ii,3),:),...
            red_img_avg(Cijk(ii,1),Cijk(ii,2),Cijk(ii,3)));

        %assign to distance matrix
        dist_subset=dist(range_i,range_j,range_k);
        label_subset=label(range_i,range_j,range_k);
        %find points within search range
        dist_logical=d<dist_subset;
        dist_subset(dist_logical)=d(dist_logical);
        label_subset(dist_logical)=ii;
        dist(range_i,range_j,range_k)=dist_subset;
        label(range_i,range_j,range_k)=label_subset;
        
    end
    %% 
    %compute new cluster centers
    %% 
    for ii=1:length(Cijk)
        c_logic=(label==ii);
        [c_i,c_j,c_k]=ind2sub(size(label),find(c_logic));
        c_green_int=nm_img_stack_listed(c_logic,:);
        c_red_int=red_img_avg(c_logic);
        
        cluster_points=[c_i,c_j,c_k,c_red_int,c_green_int];
        if (length(cluster_points)>0)
            new_center=mean(cluster_points,1);
            Err(ii)=sqrt(sum((CijkRG(ii,:)-new_center).^2));
        
            Cijk(ii,:)=round(new_center(1:3));
            CijkRG(ii,:)=round(new_center);
        end
    end
    %% 
    
    disp(sqrt(sum(Err(Err~=inf).^2)));
end
%enfore connectivity
[label,num_objects]=enforce_connectivity(label,Cijk);
num_disp_clusters=10;
label_filtered=find_plot_top_n_clusters(length(Cijk(:,1)),img_stack,label,red_img_avg,num_disp_clusters);