clear
addpath('dataset')
load('union_interactome.mat')

intersection = union_interactome;

for i=1:size(union_interactome, 1)
   if (ismember(union_interactome.Database_Source(i), 'IID, BioGrid'))
      index = intersection.Gene_Symbol_A == union_interactome.Gene_Symbol_A(i);
      intersection(index) = [];
   end
end