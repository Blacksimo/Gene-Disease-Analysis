clear
addpath('dataset')
load('graph_LCC.mat')

population_U = size(U.Nodes,1);

m = mcl(U.adjacency, 0, 0, 0, 0, 0);

g_union = digraph(m, U.Nodes);
plot(g_union)

[bins_U, binsize_U] = conncomp(g_union,'Type','weak');

idx_U = binsize_U(bins_U) >= 10;
U_cleaned = subgraph(g_union, idx_U);
plot(U_cleaned)

[bins_clean_U, binsize_clean_U] = conncomp(U_cleaned,'Type','weak');

pvalue_U = [];
test_passed_clusters_U = {};
counter_U = 1;
for i=1:size(binsize_clean_U,2)
    temp_logic_class_U = bins_clean_U == i;
    temp_subgraph_U = subgraph(U_cleaned, temp_logic_class_U);
    pvalue_U = [pvalue_U; hygepdf(1, population_U, size(temp_subgraph_U.Nodes,1), 106)];
    if pvalue_U(i) <= 0.05
        temp_indeces_U = bins_clean_U == i;
        test_passed_clusters_U{counter_U} = subgraph(U_cleaned, temp_indeces_U);
        counter_U = counter_U +1;
    end
end

