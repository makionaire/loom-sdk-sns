var contract;
var from;

window.addEventListener(`load`, async function () {

        const privateKey = loom.CryptoUtils.generatePrivateKey()
        const publicKey = loom.CryptoUtils.publicKeyFromPrivateKey(privateKey)
        const client = new loom.Client(
            'default',
            'ws://127.0.0.1:46657/websocket',
            'ws://127.0.0.1:9999/queryws',
        )

        from = loom.LocalAddress.fromPublicKey(publicKey).toString()

        const web3 = new Web3(new loom.LoomProvider(client, privateKey))
        contract = new web3.eth.Contract(contractABI, "0x60ab575af210cc952999976854e938447e919871", { from })

});
