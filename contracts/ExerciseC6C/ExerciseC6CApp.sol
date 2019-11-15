pragma solidity ^0.5.0;

// It's important to avoid vulnerabilities due to numeric overflow bugs
// OpenZeppelin's SafeMath library, when used correctly, protects agains such bugs
// More info: https://www.nccgroup.trust/us/about-us/newsroom-and-events/blog/2018/november/smart-contract-insecurity-bad-arithmetic/

import "../../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";


contract ExerciseC6CApp {
    using SafeMath for uint256; // Allow SafeMath functions to be called for all uint256 types (similar to "prototype" in Javascript)


    address private contractOwner;              // Account used to deploy contract
    // Add "state variable" for the external data contract
    ExerciseC6C exerciseC6C; // NEEDS TO BE INITIALIZED... see Constructor

    // Define debugging event
    event Logging(string _message, string _text, address _addr);


    // There is one of these modifiers in EACH contract now...
    modifier requireContractOwner()
    {
        require(msg.sender == contractOwner, "Caller is not contract owner");
        _;
    }
    
    constructor
                                (
                                    // Address parameter for data contract
                                    // Passed the address of the deployed instance
                                    // of the data contract
                                    // data contract is deployed first / previously
                                    // ONLY here and NOT on data contract because
                                    // The calls are UNIDIRECTIONAL - only calling
                                    // INTO the data contract from here - NEVER from
                                    // there to here
                                    address dataContract // INPUT to constructor
                                ) 
                                public 
    {
        contractOwner = msg.sender;
        exerciseC6C = ExerciseC6C(dataContract);    // Initialize the state var
    }



// App Logic Moved out of original COMBINED data and logic App
// NOTE: The functions that directly work on the struct/data object
// REMAINED in the data contract... i.e MORE than just the data 
// object itself

    function calculateBonus
                            (
                                uint256 sales
                            )
                            internal
                            view
                            requireContractOwner
                            returns(uint256)
    {
        if (sales < 100) {
            return sales.mul(5).div(100);
        }
        else if (sales < 500) {
            return sales.mul(7).div(100);
        }
        else {
            return sales.mul(10).div(100);
        }
    }

    function addSale
                                (
                                    string calldata id,
                                    uint256 amount
                                )
                                external
                                requireContractOwner
    {
    // Emit debug event
    emit Logging("Inside addSale: id & msg.sender = ", id, msg.sender );
 

        exerciseC6C.updateEmployee(
                        id,
                        amount,
                        555
                        // calculateBonus(amount)
        );
    }


// Stub
    // function updateEmployee
    //                             (
    //                                 string memory id,
    //                                 uint256 sales,
    //                                 uint256 bonus

    //                             )
    //                             internal // They didn't bring the modifier
    // {

    // }



}

// NOW REPLACE THE Stub With EXTERNAL CONTRACT REFERENCE... C++ Prototype like
// This is OUTSIDE
contract ExerciseC6C {
    function updateEmployee(string calldata id, uint256 sales, uint256 bonus)
    external;
}
