num_clusters=100;
f=5;


nm_img_stack=normalize_t(img_stack,0);


Lx=size(nm_img_stack,1);
Ly=size(nm_img_stack,2);
Lz=size(nm_img_stack,3);
Sxy=(f*Lx^2*Lz/num_clusters)^(1/3);
Nxy=(Lx*num_clusters/(f*Lz))^(1/3);
Nz=(f^2*Lz^2*num_clusters/(Lx^2))^(1/3);

%S_z=S_xy/10, sz_x/S_xy+sz_y/S_xy+sz_z/S_z=num_clusters
%
[gx,gy,gz]=meshgrid(linspace(1,Lx,round(Nxy)),linspace(1,Ly,round(Nxy)),...
    linspace(1,Lz,round(Nz)));
Cxyz=round([reshape(gx,[],1),reshape(gy,[],1),reshape(gz,[],1)]);

%this is just a placeholder, this will have to be fixed later
Cxyz=move_to_min_grad(nm_img_stack(:,:,:,1),Cxyz);
