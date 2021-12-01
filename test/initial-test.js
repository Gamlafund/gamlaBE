const { expect } = require("chai");
const { ethers } = require("hardhat");

// function createCommunityFund(int numberOfParticipants, int recurringAmount, int duration, unit startDate, address[] participants) {

describe("Community Fund", function () {
  let communityFundFactory;
  let communityFund;
  let participants;

  before( async ()=>{
    const CommunityFundFactory = await ethers.getContractFactory("CommunityFundFactory");
    communityFundFactory = await CommunityFundFactory.deploy();
    await communityFundFactory.deployed();

    participants = (await ethers.getSigners()).map(account => account.address);
  })

  it("Should create a Community Fund", async  ()=> {
    const deployCommunityFund = await communityFundFactory.createCommunityFund(participants, 1000, 12, 1638314000)
    const CommunityFund = await ethers.getContractFactory("CommunityFund");

    communityFund = CommunityFund.attach((await deployCommunityFund.wait()).events[0].args.communityFundAddress);

    let   communityFundData = await communityFund.getCommunityFundData();

    expect(await communityFundData.participants.length == participants.length);
    expect(await communityFundData.recurringAmount.toNumber() == 1000);
    expect(await communityFundData.duration.toNumber() == 12);
  });

  it("Should have 0 balance at first", async  ()=> {
    expect( (await hre.ethers.provider.getBalance(communityFund.address)).toBigInt() == 0);
  });

  // TODO: deposit amount on the community fund contract and verify the contract balances matches it.
});
