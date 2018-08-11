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
        contract = new web3.eth.Contract(contractABI, "0xea59a949651ffc6d3e039db2d89f4e047301718d", { from })
});
