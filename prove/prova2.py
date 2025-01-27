import json
import requests


ENRICHR_URL = 'http://amp.pharm.mssm.edu/Enrichr/enrich'
query_string = '?userListId=%s&backgroundType=%s'
user_list_id = 25631613
gene_set_library = 'KEGG_2019_Human'
response = requests.get(
    ENRICHR_URL + query_string % (user_list_id, gene_set_library)
 )
if not response.ok:
    raise Exception('Error fetching enrichment results')

data = json.loads(response.text)
print(data)