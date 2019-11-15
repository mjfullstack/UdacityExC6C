pragma solidity ^0.5.0;

// It's important to avoid vulnerabilities due to numeric overflow bugs
// OpenZeppelin's SafeMath library, when used correctly, protects agains such bugs
// More info: https://www.nccgroup.trust/us/about-us/newsroom-and-events/blog/2018/november/smart-contract-insecurity-bad-arithmetic/

import "../../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";


contract ExerciseC6C {
    using SafeMath for uint256; // Allow SafeMath functions to be called for all uint256 types (similar to "prototype" in Javascript)

    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/

    struct Profile {
        string id;
        bool isRegistered;
        bool isAdmin;
        uint256 sales;
        uint256 bonus;
        address wallet;
    }

    address private contractOwner;              // Account used to deploy contract
    mapping(string => Profile) employees;      // Mapping for storing employees

    /********************************************************************************************/
    /*                                       EVENT DEFINITIONS                                  */
    /********************************************************************************************/

    // No production events
    // Define debugging event
    event Logging(string _message, string _text, bool _regd, address _addr);
        

    /**
    * @dev Constructor
    *      The deploying account becomes contractOwner
    */
    constructor
                                (
                                ) 
                                public 
    {
        contractOwner = msg.sender;
    }

    /********************************************************************************************/
    /*                                       FUNCTION MODIFIERS                                 */
    /********************************************************************************************/

    // Modifiers help avoid duplication of code. They are typically used to validate something
    // before a function is allowed to be executed.

    /**
    * @dev Modifier that requires the "ContractOwner" account to be the function caller
    */
    modifier requireContractOwner()
    {
        require(msg.sender == contractOwner, "Caller is not contract owner");
        _;
    }

    /********************************************************************************************/
    /*                                       UTILITY FUNCTIONS                                  */
    /********************************************************************************************/

   /**
    * @dev Check if an employee is registered
    *
    * @return A bool that indicates if the employee is registered
    */   
    function isEmployeeRegistered
                            (
                                string calldata id
                            )
                            external
                            view // remove for logging
                            returns(bool)
    {
        // Emit debug event
        // emit Logging("Inside isEmployeeRegistered: id & isRegd & msg.sender = ", id, employees[id].isRegistered, msg.sender );
       
        return employees[id].isRegistered;
    }

    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

    // NOTE: The functions that directly work on the struct/data object
    // REMAINED in the data contract... i.e MORE than just the data 
    // object itself

    function registerEmployee
                                (
                                    string calldata id,
                                    bool isAdmin,
                                    address wallet
                                )
                                external
                                requireContractOwner
    {
        require(!employees[id].isRegistered, "Employee is already registered.");

        employees[id] = Profile({
                                        id: id,
                                        isRegistered: true,
                                        isAdmin: isAdmin,
                                        sales: 0,
                                        bonus: 0,
                                        wallet: wallet
                                });
    }

    function getEmployeeSales
                            (
                                string calldata id
                            )
                            external
                            view
                            requireContractOwner
                            returns(uint256)
    {
        return employees[id].sales;
    }

    function getEmployeeBonus
                            (
                                string calldata id
                            )
                            external
                            view
                            requireContractOwner
                            returns(uint256)
    {
        return employees[id].bonus;
    }

    function updateEmployee
                                (
                                    string calldata id,
                                    uint256 sales,
                                    uint256 bonus

                                )
                                external
                                // REMOVED since APP/Logic contract will be calling this
                                // requireContractOwner 
    {
        // Emit debug event
        emit Logging("Inside updateEmployee: id & isRegd & msg.sender = ", id, employees[id].isRegistered, msg.sender );
       
        // require(employees[id].isRegistered, "Employee is not registered.");

        employees[id].sales = employees[id].sales.add(sales);
        employees[id].bonus = employees[id].bonus.add(bonus);

    }



}