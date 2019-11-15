// migrating the appropriate contracts
var ExerciseC6C    = artifacts.require("./ExerciseC6C/ExerciseC6C.sol");
var ExerciseC6CApp = artifacts.require("./ExerciseC6C/ExerciseC6CApp.sol");

module.exports = function(deployer) {
  deployer.deploy(ExerciseC6C).then( () => {
    return deployer.deploy(ExerciseC6CApp, ExerciseC6C.address);
  });
};
