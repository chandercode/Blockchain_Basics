// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRecordSystem {

    // Student structure
    struct Student {
        uint256 id;
        string name;
        uint256 age;
        string course;
    }

    // Student ID => Student
    mapping(uint256 => Student) public students;

    // Number of students currently stored
    uint256 public studentCount;

    // Contract owner
    address public owner;

    // Events
    event StudentAdded(
        uint256 id,
        string name
    );

    event StudentUpdated(
        uint256 id,
        string name
    );

    event StudentDeleted(
        uint256 id
    );

    // Only owner can call the function
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only owner can perform this action"
        );
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Add a new student
    function addStudent(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _course
    ) public onlyOwner {

        require(
            students[_id].id == 0,
            "Student already exists"
        );

        students[_id] = Student(
            _id,
            _name,
            _age,
            _course
        );

        studentCount++;

        emit StudentAdded(_id, _name);
    }

    // Get student details
    function getStudent(
        uint256 _id
    )
        public
        view
        returns (
            uint256 id,
            string memory name,
            uint256 age,
            string memory course
        )
    {
        require(
            students[_id].id != 0,
            "Student does not exist"
        );

        return (
            students[_id].id,
            students[_id].name,
            students[_id].age,
            students[_id].course
        );
    }

    // Update student
    function updateStudent(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _course
    ) public onlyOwner {

        require(
            students[_id].id != 0,
            "Student does not exist"
        );

        students[_id].name = _name;
        students[_id].age = _age;
        students[_id].course = _course;

        emit StudentUpdated(_id, _name);
    }

    // Delete student
    function deleteStudent(
        uint256 _id
    ) public onlyOwner {

        require(
            students[_id].id != 0,
            "Student does not exist"
        );

        delete students[_id];

        studentCount--;

        emit StudentDeleted(_id);
    }

    // Check whether student exists
    function studentExists(
        uint256 _id
    ) public view returns (bool) {

        return students[_id].id != 0;
    }
}
