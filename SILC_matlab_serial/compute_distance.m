function [D]=compute_distance(scale_ijk,scale_Ir,...
                ig,jg,kg,...
                Ig,Ir,...
                ijkC,IgC,IrC)
    a=1;
    b=1;

    IgCmap=repmat(IgC,[size(Ir)]);
    IrCmap=IrC*ones(size(Ir));
    sz=size(ig);
    
    dt=1-sum(Ig.*IgCmap,4);
    dijk=sqrt((ig-ijkC(1)*ones(sz)).^2+...
              (jg-ijkC(2)*ones(sz)).^2+...
              (kg-ijkC(3)*ones(sz)).^2);
    dI=abs(Ir-IrCmap);
    
    D=dt+a*scale_ijk*dijk+b*scale_Ir*dI;
    

end