% clear
addpath('dataset')
addpath('utils')
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
% plot(g_SGI,'Layout','force');
% array = [interactions_only_genes.Gene_Symbol_A; interactions_only_genes.Gene_Symbol_B];

[bin,binsize] = conncomp(g_SGI,'Type','weak');
idx = binsize(bin) == max(binsize);
SGI = subgraph(g_SGI, idx);
% plot(SGI)

d_SGI = SGI.distances;
d_SGI = mean(mean(d_SGI));

m_SGI = mean(SGI.degree);

[ L, EGlob, cc_SGI, ELocClosed, COpen, ELocOpen ] = graphProperties(SGI.adjacency);

[r_SGI, d_SGI] = radiusAndDiameter(SGI.adjacency);

density = size(SGI.Edges, 1)/(size(SGI.Nodes, 1)*(size(SGI.Nodes, 1)-1));

centralization = (size(SGI.Nodes, 1)/(size(SGI.Nodes, 1)-2))*(max(SGI.degree)/(size(SGI.Nodes, 1)-1)-density);

%UNION INTERACTOME GRAPH
g_U = graph(union_interactome.Gene_Symbol_A, union_interactome.Gene_Symbol_B);
% plot(g_U,'Layout','force');

% array_U = [union_interactome.Gene_Symbol_A;  union_interactome.Gene_Symbol_B];

[bin_U,binsize_U] = conncomp(g_U,'Type','weak');
idx_U = binsize_U(bin_U) == max(binsize_U);
U = subgraph(g_U, idx_U);
% plot(U)

d_U = U.distances;
d_U = mean(mean(d_U));

m_U = mean(U.degree);

[ L, EGlob, cc_U, ELocClosed, COpen, ELocOpen ] = graphProperties(U.adjacency);

[r_U, d_U] = radiusAndDiameter(U.adjacency);

density = size(U.Edges, 1)/(size(U.Nodes, 1)*(size(U.Nodes, 1)-1));

centralization = (size(U.Nodes, 1)/(size(U.Nodes, 1)-2))*(max(U.degree)/(size(U.Nodes, 1)-1)-density);

U_nodes_degree = U.degree;

U_betweeness = U.centrality('betweenness');
U_closeness = U.centrality('closeness');
U_eigenvector = U.centrality('eigenvector');
U_ratio = U.centrality('betweenness')/U.degree;


%INTERSECTION INTERACTOME GRAPH
g_I = graph(intersection.Gene_Symbol_A, intersection.Gene_Symbol_B);
% plot(g_I,'Layout','force');

% array_I = [intersection.Gene_Symbol_A ; intersection.Gene_Symbol_B];

[bin_I,binsize_I] = conncomp(g_I,'Type','weak');
idx_I = binsize_I(bin_I) == max(binsize_I);
I = subgraph(g_I, idx_I);
% plot(I)

d_I = I.distances;
d_I = mean(mean(d_I));

m_I = mean(I.degree);

[ L, EGlob, cc_I, ELocClosed, COpen, ELocOpen ] = graphProperties(I.adjacency);

[r_I, d_I] = radiusAndDiameter(I.adjacency);

density = size(I.Edges, 1)/(size(I.Nodes, 1)*(size(I.Nodes, 1)-1));

centralization = (size(I.Nodes, 1)/(size(I.Nodes, 1)-2))*(max(I.degree)/(size(I.Nodes, 1)-1)-density);

I_nodes_degree = I.degree;

I_betweeness = I.centrality('betweenness');
I_closeness = I.centrality('eigenvector');
I_eigenvector = I.centrality('closeness');
I_ratio = I.centrality('betweenness')/I.degree;




