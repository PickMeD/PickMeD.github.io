userPrivateAbi = [
	{
		"constant": true,
		"inputs": [
			{
				"name": "_addr",
				"type": "address"
			}
		],
		"name": "getPrivateInfo",
		"outputs": [
			{
				"name": "",
				"type": "string"
			},
			{
				"name": "",
				"type": "string"
			},
			{
				"name": "",
				"type": "address[]"
			},
			{
				"name": "",
				"type": "address[]"
			}
		],
		"payable": false,
		"stateMutability": "view",
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
		"constant": false,
		"inputs": [
			{
				"name": "_certType",
				"type": "string"
			},
			{
				"name": "_certId",
				"type": "string"
			},
			{
				"name": "_voteRefuseCompanyAddr",
				"type": "address[]"
			},
			{
				"name": "_recruitingCompanyAddr",
				"type": "address[]"
			}
		],
		"name": "insertPrivateInfo",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "newOwenr",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_addr",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "newAddr",
				"type": "address"
			}
		],
		"name": "TransferOwnership",
		"type": "event"
	}
]