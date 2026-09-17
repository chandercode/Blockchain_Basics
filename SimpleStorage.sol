// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Storage{
uint256 private storedNumber;
string private storedName;

address public lastUpdatedBy;

event NumberUpdated(
    uint256 oldNumber,
    uint256 newNumber,
    address updatedBy
);

event NameUpdated(
    string oldName,
    string newName,
    address updatedBy
);

constructor(){
    storedNumber=0;
    storedName="";
    lastUpdatedBy=msg.sender;
}

function setNumber(uint256 _Number)public {
    uint256 oldNumber=storedNumber;
    storedNumber=_Number;
    lastUpdatedBy=msg.sender;

    emit NumberUpdated(
        oldNumber,
        _Number,
        lastUpdatedBy
    );

}
function getNumber()public view returns(uint256){
    return storedNumber;
}

function setName(string memory _name)public {
    string memory oldName=storedName;
    storedName=_name;
    lastUpdatedBy=msg.sender;

    emit NameUpdated(
        oldName,
        _name,
        lastUpdatedBy
    );
}
 function getName() public view returns (string memory) {
        return storedName;
    }
    function getLastUpdatedBy() public view returns (address) {
        return lastUpdatedBy;
    }
     function resetNumber() public {
        uint256 oldNumber = storedNumber;

        storedNumber = 0;
        lastUpdatedBy = msg.sender;

        emit NumberUpdated(
            oldNumber,
            0,
            msg.sender
        );
    }

}
