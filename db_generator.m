clear
load('data_table.mat')
% Interactions for human 'gene' and interactions between all interactors of 'gene':
% TaxID corresponds to homo sapiens
api_interaction = 'https://webservice.thebiogrid.org/interactions/?searchNames=true&taxId=9606&includeInteractors=true&includeInteractorInteractions=true&accesskey=49a2e0ca3aa9d99df092f2d0cbf92b8d&format=json&geneList=';
fprintf('-------------------------------------------------------\n');
counter = 0;
gene_list = {};
symbol_a_list = {};
symbol_b_list = {};
options = weboptions("Timeout", 20);

for i=1:size(complete_data, 1)
    symbol = complete_data.Gene_Symbol(i,:);
    fprintf('Analyzing Gene: %s \t %u/%u \n', string(symbol), i, size(complete_data,1));
    data = webread(strcat(api_interaction, string(symbol)), options);
    if ~isempty(data)
        data = struct2cell(data);
        fprintf('Found %u Interactions with the Gene \n', size(data,1));
        
        for j=1:size(data,1)
            symbol_a_list = [symbol_a_list;  upper(data{j,1}.OFFICIAL_SYMBOL_A)];
            symbol_b_list = [symbol_b_list;  upper(data{j,1}.OFFICIAL_SYMBOL_B)];   
%             if  ~any(contains(gene_list, upper(data{j,1}.OFFICIAL_SYMBOL_A)))
%                 counter = counter + 1;
%                 gene_list{counter, 1} = upper(data{j,1}.OFFICIAL_SYMBOL_A);
%             end
%             if  ~any(contains(gene_list, upper(data{j,1}.OFFICIAL_SYMBOL_B)))
%                 counter = counter + 1;
%                 gene_list{counter, 1} = upper(data{j,1}.OFFICIAL_SYMBOL_B);
%             end
        end
        fprintf('-------------------------------------------------------\n');
    else
        fprintf('Found no data \n');
        fprintf('-------------------------------------------------------\n');
    end
    graph_data = graph(symbol_a_list, symbol_b_list);
    complete_gene_list = table2cell(graph_data.Nodes);
end



% From IID Database:
% 8 query IDs had no PPIs:
% CPT1B, PDX1, COX2, ND1, SLC2A4, SLC9A3, ACOT1, NCF1
% 7,445 entries
% a = readtable('PPIs.txt');
