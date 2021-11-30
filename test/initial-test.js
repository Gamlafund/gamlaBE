const { expect } = require("chai");
const { ethers } = require("hardhat");

// function createCommunityFund(int numberOfParticipants, int recurringAmount, int duration, unit startDate, address[] participants) {

describe("Community Fund", function () {
  let communityFundFactory;

  before( async ()=>{
    const CommunityFundFactory = await ethers.getContractFactory("CommunityFundFactory");
    communityFundFactory = await CommunityFundFactory.deploy();
    await communityFundFactory.deployed();
  })
  it("Create a Community Fund", async  ()=> {
    let accounts = await ethers.getSigners();

    const deployCommunityFund = await communityFundFactory.createCommunityFund(10, 1000, 12, 1638314000, [accounts[0].address])
    const CommunityFund = await ethers.getContractFactory("CommunityFund");

    const communityFund = CommunityFund.attach((await deployCommunityFund.wait()).events[0].args.communityFundAddress);
    let   communityFundData = await communityFund.getCommunityFundData();

    expect(await communityFundData.numberOfParticipants.toNumber() == 10);
    expect(await communityFundData.recurringAmount.toNumber() == 1000);
    expect(await communityFundData.duration.toNumber() == 12);
  });
});
