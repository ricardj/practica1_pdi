function Pract1_PDI

%%
%GROUP NUMBER: PDI4
%GROUP MEMBERS: Alex Cabezas Fontanals, Ricard Juan Pujol
%SOFTWARE & VERSION: 9.5.0,878302

%%
close all;

%Read the input image
[img_filename, img_pathname] = uigetfile({'*.jpg';'*.jpeg';'*.png'},'Choose an image');
img = imread(strcat(img_pathname,img_filename));
imshow(img);

%Input dialog
answer = inputdlg("Enter the number of ROI's", "ROI chooser");
roiNumber = str2double(answer(1));
%msgbox("Use the mouse to draw a polygon to select the " + roiNumber + " ROI(s).","ROI settings");
roiNumber = uint8(roiNumber);

%Once we get the image we take it to chromatic values
for arrayIndex = 1:roiNumber
    h = imrect;
    mask = h.createMask();
    mask = im2uint8(mask)/255;
    newImage = img.*mask;
    rectPosition = getPosition(h)
    %rectSize = size(mask)
    croppedImage = imcrop(newImage, rectPosition);
    croppedImages{arrayIndex} = croppedImage;
end
close all;

columns = 2;
rows = 1;
for index = 1:roiNumber
    figure(double(index));
    subplot(rows,columns,1);
    imshow(croppedImages{1});
    title("ROI - Original Image");
    subplot(rows,columns,2);
    imhist(croppedImages{1});
    title("Image Histogram.");
    position  = ginput(1);
    %TODO: normalizar para mejor tresholding
    bynarizedImage = rgb2gray(croppedImages{index});
    bynarizedImage(bynarizedImage <= position(1)) = 0;
    bynarizedImage(bynarizedImage > position(1)) = 255;
    bynarizedImages{index} = bynarizedImage;
end
close all;

columns = 1;
rows = 2;

for index = 1:roiNumber
    figure(double(index));
    subplot(rows,columns,1);
    imshow(croppedImages{index});
    title("Original image");
    subplot(rows,columns,2);
    imshow(bynarizedImages{index});
    title("Bynary mask");
end

%We create a list dialog with the operations
operationList = {
    "Dilation",
    "Erosion",
    "Closing",
    "Opening",
    "Skeletonitzation"
    };
strelList = {
 "Square",
 "Horizontal",
 "Vertical"
}


option = "Yes";
while strcmp(option,"Yes")
    [operation,okOperation] = listdlg('ListString',operationList);

    switch operationList{operation}
        case "Dilation"
            
        case "Erosion"
        case "Closing"
        case "Opening"
        case "Skeletonitzation"
        otherwise
            disp("Error: Operation not finded");
    end
    
    for index = 1:roiNumber
        figure(double(index));
        subplot(rows,columns,1);
        imshow(croppedImages{index});
        title("Original image");
        subplot(rows,columns,2);
        imshow(bynarizedImages{index});
        title("Bynary mask");
    end
    
    option = questdlg("Do you want to continue applying operations?","Operation checker","Yes","No","Yes");
end

