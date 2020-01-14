clear
addpath('dataset')
addpath('prove')
load('seed_genes_interactome.mat')

% array = unique([union_interactome.Gene_Symbol_A; union_interactome.Gene_Symbol_B]);

% t = readtable('example_enrichment.txt');


% list_a = {};
% list_b = {};
% 
% for i=1:size(interactions_only_genes,1)
%    if  interactions_only_genes.Gene_Symbol_A(i) ~= interactions_only_genes.Gene_Symbol_B(i)
%       list_a = [list_a;  interactions_only_genes.Gene_Symbol_A(i)];
%       list_b = [list_b;  interactions_only_genes.Gene_Symbol_B(i)];
%    end
% end

g1 = graph(interactions_only_genes.Gene_Symbol_A, interactions_only_genes.Gene_Symbol_B);
plot(g1,'Layout','force');
array = [interactions_only_genes.Gene_Symbol_A; interactions_only_genes.Gene_Symbol_B];

[bin,binsize] = conncomp(g1,'Type','weak');
idx = binsize(bin) == max(binsize);
SG = subgraph(g1, idx);
plot(SG)

d = SG.distances;
d = mean(mean(d));

m = mean(SG.degree);

SG.

g2 = graph(union_interactome.Gene_Symbol_A, union_interactome.Gene_Symbol_B);
plot(g2,'Layout','force');

g3 = graph(intersection.Gene_Symbol_A, intersection.Gene_Symbol_B);
plot(g3,'Layout','force');