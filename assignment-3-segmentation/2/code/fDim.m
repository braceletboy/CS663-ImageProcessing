function [fND fSeq] = fDim(ND,dim)
%% Purpose:
%Take any N-D matrix in MATLAB and flatten it down into an N x size(ND,dim)
%2-D matrix.  This is often times necessary when writing complex operations 
%on multi-dimensional matrices.  It is also desired that after flattening, 
%the dimension that is preserved has the correct sequence. This is especially
%important for vector processing.
%
%% Inputs:
% ND            [O x P x Q x R x S x ...]           Any matrix with any
%                                                   number, N, of
%                                                   dimensions.
%
% dim           double                              Specify a single
%                                                   dimension in which to
%                                                   preserve when creating
%                                                   the columns of the 2-D
%                                                   flattened matrix.
%
%% Outputs:
% fND           [N x size(ND,dim)]                  A 2-D matrix with
%                                                   N corresponding to the
%                                                   same number of elements
%                                                   in the ND matrix but
%                                                   with a single dimension
%                                                   preserved.
%
% fSeq           struct                             fSeq.dim is the initial
%                                                   location of the desired
%                                                   dimension(s) before the
%                                                   shift sequence.
%                                                   
%                                                   fSeq.postShift is the
%                                                   matrix dimensions
%                                                   before the reshaping
%                                                   sequence.
%% Created By Darin Koblick (C) 07/19/2012
%Take the desired dimension and shift it up-front before reshaping the array
iND = shiftdim(ND,dim);
fSeq.postShift = size(iND);
fSeq.dim = dim;
fND = reshape(iND,numel(ND)/size(ND,dim),size(ND,dim));
end