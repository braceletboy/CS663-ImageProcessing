
function [randomblock] = getRandomBlock(blocks)
[~ ,~ , c] = size(blocks);
randomn = randi(c);
randomblock = blocks(:,:,randomn);