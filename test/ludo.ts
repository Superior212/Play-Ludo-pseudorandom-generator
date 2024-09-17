import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("Ludo", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployLudo() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await hre.ethers.getSigners();

    const Ludo = await hre.ethers.getContractFactory("PlayLudo");
    const ludo = await Ludo.deploy();

    return { ludo, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should set the right unlockTime", async function () {
      const { ludo } = await loadFixture(deployLudo);

      expect(await ludo.joinGame()).to.equal(1);
    });

    it("Should set the right owner", async function () {
      const { ludo, owner } = await loadFixture(deployLudo);

      expect(await ludo.checkWinner()).to.equal(1);
    });
  });
});
