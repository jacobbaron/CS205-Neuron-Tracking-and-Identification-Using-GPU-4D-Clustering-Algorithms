
path = 'C:\temp\imageJ_Process\filter\r\';
for i =1:13
    imwrite(r(:,:,i), [path, num2str(i), '.tif']);
end


path = 'C:\temp\imageJ_Process\filter\o\';
for i =1:13
    imwrite(o(:,:,i), [path, num2str(i), '.tif']);
end

path = 'C:\temp\imageJ_Process\filter\b\';
for i =1:13
    imwrite(b(:,:,i), [path, num2str(i), '.tif']);
end


path = 'C:\temp\imageJ_Process\filter\g\';
for i =1:13
    imwrite(g(:,:,i), [path, num2str(i), '.tif']);
end