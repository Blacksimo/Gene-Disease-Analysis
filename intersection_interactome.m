clear
addpath('dataset')
load('union_interactome.mat')

counter = 0;

for i=1:size(union_interactome, 1)
   if ismember(union_interactome.Database_Source(i), 'IID, BioGrid')
       if counter == 0
           intersection = table(union_interactome.Gene_Symbol_A(i), union_interactome.Gene_Symbol_B(i), union_interactome.Uniprot_A(i), union_interactome.Uniprot_B(i), union_interactome.Database_Source(i));
          counter = counter + 1; 
       else
           intersection = [intersection; table(union_interactome.Gene_Symbol_A(i), union_interactome.Gene_Symbol_B(i), union_interactome.Uniprot_A(i), union_interactome.Uniprot_B(i), union_interactome.Database_Source(i))];
       end
   end
end