var Test = require('../config/testConfig.js');

contract('ExerciseC6C', async (accounts) => {

  var config;
  before('setup contract', async () => {
    config = await Test.Config(accounts);
  });

  it('Can register an Employee...', async () => {
        // // Show size of contract
        // const ex6cDeployed = await config.exerciseC6C.deployed()
        // const ex6cAppDeployed = await config.exerciseC6CApp.deployed()
        // // console.log("Show size of CONFIG contract via deployedBytecode.length:")
        // // console.log(config.constructor._json.deployedBytecode.length);
        // console.log("Show size of exerciseC6C contract via deployedBytecode.length:")
        // console.log(ex6cDeployed.constructor._json.deployedBytecode.length);
        // console.log("Show size of exerciseC6CApp contract via deployedBytecode.length:")
        // console.log(ex6cAppDeployed.constructor._json.deployedBytecode.length);
    
    // ARRANGE
    let employee = {
      id: 'test1',
      isAdmin: false,
      address: config.testAddresses[0]
    };

    // ACT
    console.log(employee.id, employee.isAdmin, employee.address);
    await config.exerciseC6C.registerEmployee(employee.id, employee.isAdmin, employee.address);

    let registeredStatus = await config.exerciseC6C.isEmployeeRegistered(employee.id); // Confirm registration
    console.log(registeredStatus);

    // ASSERT
    assert.equal(registeredStatus, true, "Employee was not registered");

  });

  it('Can register an Employee and add sale... ', async () => {
    
    // ARRANGE
    let employee = {
      id: 'test2',
      isAdmin: false,
      address: config.testAddresses[1]
    };
    let sale = 400;
    // let expectedBonus = parseInt(sale * 0.07);

    // ACT
    console.log("registerEmployee() with: ", employee.id, employee.isAdmin, employee.address);
    await config.exerciseC6C.registerEmployee(employee.id, employee.isAdmin, employee.address);

    let registeredStatusBEFORE = await config.exerciseC6C.isEmployeeRegistered(employee.id); // Confirm registration
    console.log("registeredStatusBEFORE: ", registeredStatusBEFORE);

    await config.exerciseC6CApp.addSale(employee.id, sale); 
    let employeeSales = await config.exerciseC6C.getEmployeeSales.call(employee.id);
    console.log("employeeSales() returned: ", employeeSales);

    let registeredStatusAFTER = await config.exerciseC6C.isEmployeeRegistered(employee.id); // Confirm registration
    console.log("registeredStatusAFTER: ", registeredStatusAFTER);


    // ASSERT
    assert.equal(registeredStatusBEFORE, true, "Employee was not registered");
    assert.equal(registeredStatusAFTER, true, "Employee was not registered");
    assert.equal(employeeSales.toNumber(), sale, "Employee sale was NOT recorded");

  });

/****
  it('Can register an Employee, add sale and calculate bonus', async () => {
    
    // ARRANGE
    let employee = {
      id: 'test1',
      isAdmin: false,
      address: config.testAddresses[0]
    };
    let sale = 400;
    let expectedBonus = parseInt(sale * 0.07);

    // ACT
    await config.exerciseC6C.registerEmployee(employee.id, employee.isAdmin, employee.address);
    await config.exerciseC6CApp.addSale(employee.id, 400); // Function now in logic/app Contract
    let bonus = await config.exerciseC6C.getEmployeeBonus.call(employee.id);

    // ASSERT
    assert.equal(bonus.toNumber(), expectedBonus, "Calculated bonus is incorrect incorrect");

  });
****/

});