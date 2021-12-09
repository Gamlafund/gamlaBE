const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Community Fund", function () {
  let communityFundFactory;
  let communityFund;
  
  let participants;
  let requiredNbOfParticipants = 20;

  let fundName = "Test Community Fund";

  let recurringAmount = 500;
  let startDate       = Date.now() + 86400 * 5;
  let duration        = 12;

  before( async ()=>{
    const CommunityFundFactory = await ethers.getContractFactory("CommunityFundFactory");
    communityFundFactory = await CommunityFundFactory.deploy();
    await communityFundFactory.deployed();

    [firstParticipant, secondParticipant, rest] = await ethers.getSigners();
  })

  describe("Starting a Community Fund", function () {
    it("Should create a Community Fund", async  ()=> {
      const deployCommunityFund = await communityFundFactory.createCommunityFund(
        fundName, requiredNbOfParticipants, recurringAmount, startDate, duration
      )
      const CommunityFund = await ethers.getContractFactory("CommunityFund");

      communityFund = CommunityFund.attach((await deployCommunityFund.wait()).events[0].args.communityFundAddress);
      communityFund.connect(firstParticipant);

      expect(await communityFund.name()).to.equal(fundName);
      expect(await communityFund.recurringAmount()).to.equal(recurringAmount);
      expect(await communityFund.startDate()).to.equal(startDate);
      expect(await communityFund.duration()).to.equal(duration);
    });

    it("Should have a 0 balance at first", async  ()=> {
      expect(await hre.ethers.provider.getBalance(communityFund.address)).to.equal(0);
    });
  });

  describe("Making deposits into the Community Fund", function () {
    const collateral = recurringAmount * duration
    it("Should have exactly " + collateral + " collateral from one participant", async  ()=> {
      const receipt = await communityFund.collateral({ value: collateral });
      expect((await communityFund.participants(firstParticipant.address)).balance).to.equal(collateral);
    });

    const expected = recurringAmount + collateral;
    it("Should have exactly " + expected + " deposited in the fund from one participant", async  ()=> {
      const receipt  = await communityFund.deposit({ value: recurringAmount });
      expect((await communityFund.participants(firstParticipant.address)).balance).to.equal(expected);
    });

    it("Should have exactly " + expected + " in the fund after the 1st deposit", async  ()=> {
      const expected = recurringAmount + collateral;
      expect(await hre.ethers.provider.getBalance(communityFund.address)).to.equal(expected);
    });

    it("Should have exactly " + collateral + " collateral from another participant", async  ()=> {
      const secondCommunityFundParticipant = communityFund.connect(secondParticipant);
      const receipt = await secondCommunityFundParticipant.collateral({ value: collateral });
      expect((await communityFund.participants(secondParticipant.address)).balance).to.equal(collateral);
    });

    it("Should have exactly " + expected + " deposited in the fund from another participant", async  ()=> {
      const secondCommunityFundParticipant = communityFund.connect(secondParticipant);

      const receipt = await secondCommunityFundParticipant.deposit({ value: recurringAmount });
      expect((await communityFund.participants(secondParticipant.address)).balance).to.equal(expected);
    });

    it("Should have exactly " + 2 * expected + " in the fund after the 2nd deposit", async  ()=> {
      expect(await hre.ethers.provider.getBalance(communityFund.address)).to.equal(2 * expected);
    });
  });
});
