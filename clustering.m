clear
addpath('dataset')
addpath('utils\MMCL-master')
load('graph_LCC.mat')

population = size(I.Nodes,1);

m = mcl(I.adjacency, 0, 0, 0, 0, 0);

g_intersection = digraph(m, I.Nodes);
plot(g_intersection)

[bins, binsize] = conncomp(g_intersection,'Type','weak');

idx = binsize(bins) >= 10;
I_cleaned = subgraph(g_intersection, idx);
plot(I_cleaned)

[bins_clean, binsize_clean] = conncomp(I_cleaned,'Type','weak');

pvalue = [];
pvalue_passed = [];
test_passed_clusters = {};
counter = 1;
for i=1:size(binsize_clean,2)
    temp_logic_class = bins_clean == i;
    temp_subgraph = subgraph(I_cleaned, temp_logic_class);
    pvalue = [pvalue; hygepdf(1, population, 106, size(temp_subgraph.Nodes,1))];
    if pvalue(i) <= 0.05
        temp_indeces = bins_clean == i;
        test_passed_clusters{counter} = subgraph(I_cleaned, temp_indeces);
        counter = counter +1;
        pvalue_passed = [pvalue_passed; pvalue(i)];
    end
end

t = table(table2cell(U.Nodes), normalize(U.centrality('betweenness')));