var contractABI = [
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "name": "_value",
          "type": "uint256"
        },
        {
          "indexed": false,
          "name": "_sender",
          "type": "address"
        }
      ],
      "name": "NewValueSet",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "name": "_value",
          "type": "uint256"
        },
        {
          "indexed": false,
          "name": "_sender",
          "type": "address"
        }
      ],
      "name": "NewValueSetAgain",
      "type": "event"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_value",
          "type": "uint256"
        }
      ],
      "name": "set",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_value",
          "type": "uint256"
        }
      ],
      "name": "setAgain",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "get",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        },
        {
          "name": "",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }
  ]