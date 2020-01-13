clear
addpath('dataset')
load('data_table.mat')
% Interactions for human 'gene' and interactions between all interactors of 'gene':
% TaxID corresponds to homo sapiens
load('pipe_list_seed.mat');
api_interaction = 'https://webservice.thebiogrid.org/interactions/?searchNames=true&taxId=9606&includeInteractors=true&includeInteractorInteractions=true&accesskey=49a2e0ca3aa9d99df092f2d0cbf92b8d&format=json&geneList=';
% fprintf('-------------------------------------------------------\n');
genes_found_in_db = [];
interactions_per_gene = [];
gene_list = {};
symbol_a_list = {};
symbol_b_list = {};
options = weboptions("Timeout", 20);

% for i=1:size(complete_data, 1)
%     symbol = complete_data.Gene_Symbol(i,:);
%     fprintf('Analyzing Gene: %s \t %u/%u \n', string(symbol), i, size(complete_data,1));
%     data = webread(strcat(api_interaction, string(symbol)), options);
%     if ~isempty(data)
%         
%         data = struct2cell(data);
%         fprintf('Found %u Interactions with the Gene \n', size(data,1));
%         genes_found_in_db = [genes_found_in_db; symbol];
%         interactions_per_gene = [interactions_per_gene; size(data,1)];
%         
%         for j=1:size(data,1)
%             symbol_a_list = [symbol_a_list;  upper(data{j,1}.OFFICIAL_SYMBOL_A)];
%             symbol_b_list = [symbol_b_list;  upper(data{j,1}.OFFICIAL_SYMBOL_B)];   
%         end
%         fprintf('-------------------------------------------------------\n');
%     else
%         fprintf('Found no data \n');
%         fprintf('-------------------------------------------------------\n');
%     end
%     graph_data = graph(symbol_a_list, symbol_b_list);
%     complete_gene_list = table2cell(graph_data.Nodes);
% end
% 
% gene_interactions = table(genes_found_in_db, interactions_per_gene);
% 
% plot(graph_data, 'Layout', 'force');


data = webread(strcat(api_interaction, pipe_list), options);
data = struct2cell(data);

for i=1:size(data, 1)
    symbol_a_list = [symbol_a_list;  upper(data{i,1}.OFFICIAL_SYMBOL_A)];
    symbol_b_list = [symbol_b_list;  upper(data{i,1}.OFFICIAL_SYMBOL_B)];
end

graph_data = graph(symbol_a_list, symbol_b_list);
complete_gene_list = table2cell(graph_data.Nodes);


% From IID Database:
% 8 query IDs had no PPIs:
% CPT1B, PDX1, COX2, ND1, SLC2A4, SLC9A3, ACOT1, NCF1
% 7,445 entries
% a = readtable('PPIs.txt');

