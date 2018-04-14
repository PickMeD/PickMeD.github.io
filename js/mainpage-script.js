    // Address 0x6F213A598Be7058a4248eaf0a2593210Fa8B71c3 
    // pri key d816e5e0eab23dc5573968edaed1443787b03a5dddf4b82e48818ad3634a894a

    // Address 0xCB3f76FAb25c223653a85513D2ca42BAB68D1B21
    // pri key b22563a7e548bf55fb6b230ef1733cd16f9b9a900a68c3258a0e922547a621c3

    // contact 0xdb1eb516b29ecb342067e48274b406f229c48ae4

    var Web3 = require('web3');
    var web3 = new Web3();
    web3.setProvider(new web3.providers.HttpProvider('https://ropsten.infura.io/TvuMDSQ9QbgjPihMgjvZ'));

    console.log('typeof EthJS:',               (typeof EthJS))
    console.log('Object.keys(EthJS):',         Object.keys(EthJS))
    console.log('typeof EthJS.Tx:',            (typeof EthJS.Tx))
    console.log('typeof EthJS.RLP:',           (typeof EthJS.RLP))
    console.log('typeof EthJS.Util:',          (typeof EthJS.Util))
    console.log('typeof EthJS.Buffer:',        (typeof EthJS.Buffer))
    console.log('typeof EthJS.Buffer.Buffer:', (typeof EthJS.Buffer.Buffer))

    function sendToken() {
        address = "0xCB3f76FAb25c223653a85513D2ca42BAB68D1B21" //From Etherscan
        toAddress = "0x6F213A598Be7058a4248eaf0a2593210Fa8B71c3"
        contractAddress = "0xAaFaf0A1F6F787b5d7F6Aec43FcfF18f27DB6f6a" 
        contractABI = testabi
     
        tokenContract = web3.eth.contract(contractABI).at(contractAddress)

        console.log(tokenContract.balanceOf(address).toNumber());

        var count = web3.eth.getTransactionCount(address);
        var rawTransaction = {
            "from": address,
            "nonce": web3.toHex(count),
            "gasPrice": "0x50000",
            "gasLimit": "0x50000",
            "to": contractAddress,
            "value": "0x100",
            "data": tokenContract.transfer.getData(toAddress, 100000000, {from: address}),
            "chainId": "0x03"
        };

        var privKey = new EthJS.Buffer.Buffer('b22563a7e548bf55fb6b230ef1733cd16f9b9a900a68c3258a0e922547a621c3', 'hex');
        var tx = new EthJS.Tx(rawTransaction);

        tx.sign(privKey);
        var serializedTx = tx.serialize();

        web3.eth.sendRawTransaction('0x' + serializedTx.toString('hex'), function(err, hash) {
            if (!err)
                console.log(hash);
            else
                console.log(err);
        });
    }