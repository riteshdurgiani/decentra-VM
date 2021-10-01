const VotingMachine = artifacts.require("VotingMachine");

module.exports = function(deployer) {
    deployer.deploy(VotingMachine);
};