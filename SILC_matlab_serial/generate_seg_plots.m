range=6:9;
for ii=1:length(range)
    subplot(1,4,ii)
    imagesc(label_filtered(:,:,range(ii)))
    colormap(colorcube);
end