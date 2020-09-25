close all; clear all; clc;
srcDic = uigetdir('Images/');
cd(srcDic);

allnames = struct2cell(dir('*.jpg'));
[k,len]=size(allnames);
aviobj = VideoWriter('Scenario1_Capture.avi');

aviobj.FrameRate = 24;
open(aviobj)

for i = 1:328
    name = allnames{1,i};
    frame = imread(name);
    writeVideo(aviobj,frame);
end
close(aviobj)