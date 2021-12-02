const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Community Fund", function () {
  let communityFundFactory;
  let communityFund;
  
  let participants;

  let recurringAmount = 500;
  let startDate       = Date.now() + 86400 * 5;
  let duration        = 12;

  before( async ()=>{
    const CommunityFundFactory = await ethers.getContractFactory("CommunityFundFactory");
    communityFundFactory = await CommunityFundFactory.deploy();
    await communityFundFactory.deployed();

    participants = (await ethers.getSigners()).map(account => account.address);
  })

  it("Should create a Community Fund", async  ()=> {
    const deployCommunityFund = await communityFundFactory.createCommunityFund(
      participants, recurringAmount, startDate, duration
    )
    const CommunityFund = await ethers.getContractFactory("CommunityFund");

    communityFund = CommunityFund.attach((await deployCommunityFund.wait()).events[0].args.communityFundAddress);

    let   communityFundData = await communityFund.getCommunityFundData();

    expect(await communityFundData.participants.length == participants.length);
    expect(await communityFundData.recurringAmount.toNumber() == recurringAmount);
    expect(await communityFundData.duration.toNumber() == duration);
  });

  it("Should have a 0 balance at first", async  ()=> {
    expect( (await hre.ethers.provider.getBalance(communityFund.address)).toBigInt() == 0);
  });

  it("Should have exactly " + recurringAmount + " deposited in the fund", async  ()=> {
    const receipt = await communityFund.deposit({ value: recurringAmount });
    expect( (await hre.ethers.provider.getBalance(communityFund.address)).toBigInt() == recurringAmount);
  });
});
