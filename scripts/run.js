const main = async () => {
  //const [owner, __] = await hre.ethers.getSigners();
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.001"),
  });

  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance: ",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let totalWaves = await waveContract.getTotalWaves();
  console.log("totalWaves: ", totalWaves.toNumber());

  let waveTxn = await waveContract.wave("A message!");
  await waveTxn.wait(); // Wait for the transaction to be mined

  waveTxn = await waveContract.connect(randomPerson).wave("Another message!");
  await waveTxn.wait();
  
  waveTxn = await waveContract.wave("Another message!");
  await waveTxn.wait();

  waveTxn = await waveContract.connect(owner).wave("Another message!");
  await waveTxn.wait();

  let userBalance = await waveContract.connect(randomPerson).getUserBalance();
  await waveTxn.wait();
  console.log("userBalance for %s: %s ", randomPerson.address, userBalance);

  userBalance = await waveContract.connect(owner).getUserBalance();
  await waveTxn.wait();
  console.log("userBalance for %s: %s ", owner.address, userBalance);

  contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance: ",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allWaves = await waveContract.getAllWaves();
  console.log("allWaves: ", allWaves);
  
  totalWaves = await waveContract.getTotalWaves();
  console.log("totalWaves: ", totalWaves.toNumber());
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
