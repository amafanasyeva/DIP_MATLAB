cat_jpg=imread('cat.jpg');
cat_png=imread('cat.png');
info_jpg=imfinfo('cat.jpg');
info_png=imfinfo('cat.png');
width_jpg=getfield(info_jpg, 'Width');
width_png=getfield(info_png, 'Width');
heigh_jpg=getfield(info_jpg, 'Height');
heigh_png=getfield(info_png, 'Height');
file_size_jpg=getfield(info_jpg, 'FileSize');

K_s=((width_jpg*heigh_jpg*Bit)/8)/(File_size)