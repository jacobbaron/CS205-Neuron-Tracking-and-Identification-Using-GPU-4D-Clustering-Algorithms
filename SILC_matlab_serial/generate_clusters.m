function [Cijk,Sij,Sk]=generate_clusters(num_clusters,Li,Lj,Lk,f)

Sij=((f*Li^2*Lk)/num_clusters)^(1/3);
Sk=Sij/f;
[jgrid,igrid,kgrid]=meshgrid(Sij/2:Sij:Lj-Sij/2,...
                             Sij/2:Sij:Li-Sij/2,...
                             Sk/2:Sk:Lk-Sk/2);
Cijk=round([reshape(igrid,[],1),reshape(jgrid,[],1),reshape(kgrid,[],1)]);
Sij=round(Sij);
Sk=round(Sk);
end