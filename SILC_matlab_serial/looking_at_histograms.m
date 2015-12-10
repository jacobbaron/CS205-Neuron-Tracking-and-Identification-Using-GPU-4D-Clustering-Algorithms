close all;
subplot(2,2,1)
histogram(reshape(img_stack,[],1,1,1),'Normalization','probability');
set(gca,'xscale','log')
set(gca,'yscale','log')
xlim([5*10^1,5*10^3])
title(sprintf('Forground + Background \nGreen Channel'))
subplot(2,2,3)
histogram(reshape(img_stack(1:10,:,1,:),[],1,1,1),'Normalization','probability')
set(gca,'xscale','log')
set(gca,'yscale','log')
xlim([5*10^1,5*10^3])
title('Background Only, Green Channel')


subplot(2,2,2)
histogram(reshape(red_img_stack,[],1),'Normalization','probability');
set(gca,'xscale','log')
set(gca,'yscale','log')
xlim([5*10^1,5*10^3])
title(sprintf('Forground + Background \nRed Channel'))
subplot(2,2,4)
histogram(reshape(red_img_stack(1:10,:,:),[],1),'Normalization','probability')
set(gca,'xscale','log')
set(gca,'yscale','log')
xlim([5*10^1,5*10^3])
title('Background Only, Red Channel')
export_fig('Histograms.pdf','-transparent','-nocrop')