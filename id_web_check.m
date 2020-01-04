clear
load('cleaned_pmid_data.mat');
api_call = 'http://rest.genenames.org/fetch/symbol/';

for i=1:size(geneSymbol,1)
    data = webread(strcat(api_call, geneSymbol(i, :)));
    if data.response.numFound ~= 1
        fprintf('Error found in checking the gene symbol: %s\n', geneSymbol(i,:));
        fprintf('Number of gene found: %i\n', data.response.numFound);
        fprintf('Index in geneSymbol array: %i\n', i);
    else 
        fprintf('Gene ID analyzed: %i\n', geneId(i,:));
        fprintf('Gene ID found: %s\n', data.response.docs.hgnc_id);
    end
    
end
% data = webread('http://rest.genenames.org/fetch/symbol/ACOX1');
% data_fake = webread('http://rest.genenames.org/fetch/symbol/pippo');