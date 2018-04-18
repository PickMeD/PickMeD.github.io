interestContainerAbi = [
	{
		"constant": true,
		"inputs": [
			{
				"name": "keyWord",
				"type": "bytes24"
			}
		],
		"name": "getInterestInYn",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "keyWord",
				"type": "bytes24"
			},
			{
				"name": "_Addr",
				"type": "address"
			}
		],
		"name": "insertInterestItem",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getInterestItemList",
		"outputs": [
			{
				"name": "",
				"type": "bytes24[]"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "keyWord",
				"type": "bytes24"
			}
		],
		"name": "getInterestAddr",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "oldOwner",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "newOwenr",
				"type": "address"
			}
		],
		"name": "transferOwner",
		"type": "event"
	}
]