
const main = async () => {
  const fundFactoryContractFactory = await hre.ethers.getContractFactory('CommunityFundFactory');
  const fundFactoryContract = await fundFactoryContractFactory.deploy();
  await fundFactoryContract.deployed();

  console.log("Contract deployed to:", fundFactoryContract.address);
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

