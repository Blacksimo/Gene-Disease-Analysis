clear
addpath('dataset')
addpath('prove')
load('seed_genes_interactome.mat')
load('union_interactome.mat')
load('intersection_interactome.mat')


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


%SEED GENE INTERACTIONS GRAPH
g_SGI = graph(interactions_only_genes.Gene_Symbol_A, interactions_only_genes.Gene_Symbol_B);
plot(g_SGI,'Layout','force');
array = [interactions_only_genes.Gene_Symbol_A; interactions_only_genes.Gene_Symbol_B];

[bin,binsize] = conncomp(g_SGI,'Type','weak');
idx = binsize(bin) == max(binsize);
SGI = subgraph(g_SGI, idx);
plot(SGI)

d_SGI = SGI.distances;
d_SGI = mean(mean(d_SGI));

m_SGI = mean(SGI.degree);


%UNION INTERACTOME GRAPH
g_U = graph(union_interactome.Gene_Symbol_A, union_interactome.Gene_Symbol_B);
plot(g_U,'Layout','force');

array_U = [union_interactome.Gene_Symbol_A;  union_interactome.Gene_Symbol_B];

[bin_U,binsize_U] = conncomp(g_U,'Type','weak');
idx_U = binsize(bin_U) == max(binsize_U);
U = subgraph(g_U, idx_U);
plot(U)

d_U = g_U.distances;
d_U = mean(mean(d_U));

m_U = mean(g_U.degree);

%RIVEDERE
%INTERSECTION INTERACTOME GRAPH
g_I = graph(intersection.Gene_Symbol_A, intersection.Gene_Symbol_B);
plot(g_I,'Layout','force');

array_I = [intersection.Gene_Symbol_A ; intersection.Gene_Symbol_B];
%problema qui da inf
[bin_I,binsize_I] = conncomp(g_I,'Type','weak');
idx_I = binsize(bin_I) == max(binsize_I);
I = subgraph(g_I, idx_I);
plot(I)
%problema qui da inf
d_I = g_I.distances;
d_I = mean(mean(d_I));

m_I = mean(g_I.degree);