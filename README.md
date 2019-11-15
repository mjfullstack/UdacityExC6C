# UdacityExC6C #
Udacity Exercise C6C Separation of Concerns, Contract DATA and APP logic

### SafeMath pragma Change: ###
I had to change THIS file in node_modules to pragma ^0.5.0 and it compiled
 **.\node_modules\openzeppelin-solidity\contracts\math\SafeMath.sol**
This must be repeated if node_modules is deleted while re-doing npm install

### New Migrations Configuration ###
From: https://stackoverflow.com/questions/49785667/truffle-migrate-success-but-contract-address-is-not-displayed

"You need to return the  deployed contract from the Promise to have the contract object be injected by Truffle". Example:

var Caller = artifacts.require("Caller");

var Callee = artifacts.require("Callee");

module.exports = function(deployer) {
  deployer.deploy(Callee).then(function() {
    return deployer.deploy(Caller, Callee.address);
  });
};
 
I was unsuccessful getting the App contract and Data contracts to compile together until I added **2_deploy_contracts.sol** and configured it according to the above (see web link).



