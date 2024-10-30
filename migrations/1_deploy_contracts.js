const Storage = artifacts.require("Storage");
const RevertContract = artifacts.require("RevertContract");

module.exports = function(deployer) {
  deployer.deploy(Storage);
  deployer.deploy(RevertContract);
};
