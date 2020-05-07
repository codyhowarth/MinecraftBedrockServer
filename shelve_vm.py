#! python3
from lndynamic3 import LNDynamic

api_id = 'nfq64oy0v8r5mfdn'
api_key = 'QQQ'
api = LNDynamic(api_id, api_key)

params = {
	'vm_id': 'edaaf117-8fbe-4aa8-9b90-833ccb97685f'
}

print(api.request('vm', 'shelve', params))