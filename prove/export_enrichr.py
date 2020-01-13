
import json
import requests


ENRICHR_URL = 'http://amp.pharm.mssm.edu/Enrichr/export'
query_string = '?userListId=%s&filename=%s&backgroundType=%s'
user_list_id = 25631613
filename = 'example_enrichment'
gene_set_library = 'KEGG_2019_Human'

url = ENRICHR_URL + query_string % (user_list_id, filename, gene_set_library)
response = requests.get(url, stream=True)

with open(filename + '.txt', 'wb') as f:
    for chunk in response.iter_content(chunk_size=1024): 
        if chunk:
            f.write(chunk)