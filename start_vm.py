#! python3
from lndynamic3 import LNDynamic

api_id = 'nfq64oy0v8r5mfdn'
api_key = 'QQQ'
api = LNDynamic(api_id, api_key)

params = {
	'vm_id': 'edaaf117-8fbe-4aa8-9b90-833ccb97685f'
}

try:
	print('Unshelving + starting the luna VM now')
	print(api.request('vm', 'unshelve', params))
	print('VM is starting (may take a few minutes)')
	input('Press enter to continue')
except Exception as e:
	print('Something went wrong starting the VM: ' + str(e))