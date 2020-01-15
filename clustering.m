clear
addpath('dataset')
load('union_interactome.mat')

g_union = graph(union_interactome.Gene_Symbol_A, union_interactome.Gene_Symbol_B);
% plot(g_union,'Layout','force');

[bin,binsize] = conncomp(g_union,'Type','weak');
idx = binsize(bin) == max(binsize);
SG = subgraph(g_union, idx);
% plot(SG)


m = mcl(SG.adjacency, 0, 0, 0, 0, 0);

g_union = digraph(m);
plot(g_union)