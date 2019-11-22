texture_image = [1 2 3 5 6 7; 4 5 6 2 3 4; 7 8 10 3 4 5; 7 8 10 3 4 67; 4 5 6 2 3 4;1 2 3 5 6 7 ];
k = 3;
blocks = getslices(texture_image,k);
randomblock = getrandomblock(blocks);
disp(randomblock);
