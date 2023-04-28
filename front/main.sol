<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://cdn.jsdelivr.net/gh/ethereum/web3.js@1.0.0-beta.34/dist/web3.min.js"></script>
	<title>Document</title>
	<style>
		body
		{
			background-color: palevioletred;
			font-size: 34px;

			text-align: center;
		}

		button 
		{
			background-color: aquamarine;
			font-size: 34px;
			font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif
		}
		
		button:hover { background-color: yellow; }
		 
	</style>
</head>
<body>
	<button onclick="connectMetamask()">Connect to METAMASK</button> <br>
	<p id="accountArea"></p>
	<button onclick="connectContract()">Connect to Contract</button> <br>

	<p id="contractArea"></p>
	<button onclick="readContract()">Get data from Contract</button> <br>

	<p id="dataArea"></p>

	<script>
		let account;
		const connectMetamask = async () => {
		  if (window.ethereum != undefined)
		  {
			const accounts = await ethereum.request({method: "eth_requestAccounts"});
			account = accounts[0];
			
			document.getElementById("accountArea").innerHTML = account;
		  }
		}

		const connectContract = async () => {
		  const ABI = [
			{
				"inputs": [],
				"name": "name",
				"outputs": [
					{
						"internalType": "string",
						"name": "",
						"type": "string"
					}
				],
				"stateMutability": "view",
				"type": "function"
			}
		  ];
	 
		  const address = "0x293a3D088CA2817405835bafE01B5257946735b9";
		  const web3 = new Web3(window.ethereum);
		  window.contract = new web3.eth.Contract(ABI, address);
		  document.getElementById("contractArea").innerHTML = "Connected to smart contract";
		}
		

		const readContract = async () => {
  			const data = await window.contract.methods.myCity().call();
 			document.getElementById("dataArea").innerHTML = data;
}


	</script>
</body>
</html>
