function c=Kmean_xyzt4D(xyzt,varargin)
% c is the cluserting, optional Ninit,Niter, Nrep, lambda
% parameter lambda>0 adjust the weight over physical location proximity
xyzt=double(xyzt);

switch nargin
    case 1
        Ninit=40;
        Niter=100;
        Nrep=10;
        lambda=0;
    case 2
        Ninit=varargin{1};
        Niter=100;
        Nrep=10;
        lambda=0;
    case 3
        Ninit=varargin{1};
        Niter=varargin{2};
        Nrep=10;
        lambda=0;
    case 4
        Ninit=varargin{1};
        Niter=varargin{2};
        Nrep=10;
        lambda=0;
    case 5
        Ninit=varargin{1};
        Niter=varargin{2};
        Nrep=varargin{3};
        lambda=varargin{4};
end;

[ny,nx,nz,nt]=size(xyzt);
meanActivity=squeeze(sum(sum(sum(xyzt,1),2),3))';

InitCenters=zeros(Ninit,3+nt,Nrep);
for ir=1:Nrep
    InitCentersSpace=[randi(ny,[1,Ninit-1]);randi(nx,[1,Ninit-1]);randi(nz,[1,Ninit-1])]; %random centers
    InitCenters(1,:,ir)=[round(ny/2),round(nx/2),round(nz/2),meanActivity];
    InitCenters(2:end,1:3,ir)=InitCentersSpace';
    for i=1:Ninit-1
        iyxz=InitCentersSpace(:,i);
        InitCenters(i,4:end,ir)=xyzt(iyxz(1),iyxz(2),iyxz(3),:);
    end;
    InitCenters(:,1:3,ir)=InitCenters(:,1:3,ir)*power(lambda,1/3);
end;
xyztLin=reshape(xyzt,[ny*nx*nz,nt]);
xyztSpace=zeros(ny,nx,nz,3);
for i =1:nz
    xyztSpace(:,:,i,1) = (1:ny)'*ones(1,nx);
end
for i =1:nz
    xyztSpace(:,:,i,2) = ones(ny,1)*(1:nx);
end
for i =1:nz
    xyztSpace(:,:,i,3) = i.*ones(ny, nx);
end

xyztSpace=reshape(xyztSpace,[ny*nx*nz,3])*power(lambda,1/3);

options = statset('MaxIter',Niter);
% options = statset('MaxIter',Niter,'UseParallel',true);


IDX=kmeans([xyztSpace,xyztLin],[],'start',InitCenters,'onlinephase','off','replicates',Nrep,...
    'options',options);%,% ,'emptyaction','drop',

c=reshape(IDX,[ny,nx,nz]);

% c=zeros(ny,nx);
% NpointCenter=zeros(1,Ninit); % number of elements in each center, will eliminate empty centers
% % initialize based on xy geometry
% InitCentersSpace=[randi(ny,[1,Ninit]);randi(ny,[1,Ninit])]; %random centers
% for ix=1:nx
%     for iy=1:ny
%         [~,imin]=min((initCenters-[ny;nx]).^2);
%         c(ny,nx)=imin;
%         NpointCenter(imin)=NpointCenter(imin)+1;
%     end;
% end;
% 
% % the color 0 represents the constant activity, center y,x location
% tol=0.01; %proportion of changes
% exitFlag=0;
% iIter=1;
% SpaceTimeCenters=zeros(2+nt,Ninit); % first 2 dim are y and x
% 
% while (exitFlag==0)&&(iIter<=Niter)
%     lgNonzeroCenters=NpointCenter>0;
%     NewNcenters=sum(lgNonzeroCenters);
%     NewSpaceTimeCenters=zeros(2+nt,NewNcenters);
%     New2Old=ones(1,Ncenters);
%     New2Old=New2Old(lgNonzeroCenters);
% 
% 
% end;

end