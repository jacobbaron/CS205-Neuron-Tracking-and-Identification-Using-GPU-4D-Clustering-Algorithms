num_clusters=100;
f=5;
%load('aligned_xyzt_data')
%load('red_img_stack')

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

[Cijk,Sij,Sk]=generate_clusters(num_clusters,Li,Lj,Lk,f);
label=-1*ones(size(red_img_avg));
dist=Inf(size(red_img_avg));

%Cxyz=move_to_min_grad(red_img_avg,Cxyz);

%begin iterating!
while(true) %some condition to be determined later

%Assign the best matching pixels from a 2S_xy × 2S_xy x 2S_z cubic
%neighborhood around the cluster center according to the distance measure
    for ii=1:length(Cijk)
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
        dist_logical=d<dist_subset;
        dist_subset(dist_logical)=d(dist_logical);
        label_subset(dist_logical)=ii;
        dist(range_i,range_j,range_k)=dist_subset;
        label(range_i,range_j,range_k)=label_subset;
        
    end
    
end