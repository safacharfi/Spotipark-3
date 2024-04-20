// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;



contract Parking {
    uint256 public UserCount;
    uint256 public ParkingCount;
    uint256 public timeslotCount;

    struct User {
        uint256 id;
        string name;
        string password;
        string phone;
    }

    struct Parking {
        uint256 id;
        string name;
        string location;
        string capacity; // Changed to string
    }

    struct Timeslot {
        uint256 id;
        string duration;
        string Price;
    }

    mapping(uint256 => User) public users;
    mapping(uint256 => Parking) public parkings;
    mapping(uint256 => Timeslot) public timeslots;

    constructor() public {
        UserCount = 0;
        ParkingCount = 0;
        timeslotCount = 0;
    }

    event UserAdded(uint256 _id);
    event UserDeleted(uint256 _id);
    event UserEdited(uint256 _id);
    event ParkingAdded(uint256 _id);
    event ParkingDeleted(uint256 _id);
    event ParkingEdited(uint256 _id);
    event TimeslotAdded(uint256 _id);
    event TimeslotDeleted(uint256 _id);
    event TimeslotEdited(uint256 _id);

    function getUserCount() public view returns (uint256) {
        return UserCount;
    }

    function addUser(
        string memory _name,
        string memory _password,
        string memory _phone
    ) public {
        users[UserCount] = User(
            UserCount,
            _name,
            _password,
            _phone
        );
        emit UserAdded(UserCount);
        UserCount++;
    }

    function deleteUser(uint256 _id) public {
        delete users[_id];
        UserCount--;
        emit UserDeleted(_id);
    }

    function editUser(
        uint256 _id,
        string memory _name,
        string memory _password,
        string memory _phone
    ) public {
        users[_id] = User(_id, _name, _password, _phone);
        emit UserEdited(_id);
    }

    function getParkingCount() public view returns (uint256) {
        return ParkingCount;
    }

    function addParking(
        string memory _name,
        string memory _location,
        string memory _capacity // Changed to string
    ) public {
        parkings[ParkingCount] = Parking(
            ParkingCount,
            _name,
            _location,
            _capacity
        );
        emit ParkingAdded(ParkingCount);
        ParkingCount++;
    }

    function deleteParking(uint256 _id) public {
        delete parkings[_id];
        ParkingCount--;
        emit ParkingDeleted(_id);
    }

    function editParking(
        uint256 _id,
        string memory _name,
        string memory _location,
        string memory _capacity // Changed to string
    ) public {
        parkings[_id] = Parking(_id, _name, _location, _capacity);
        emit ParkingEdited(_id);
    }

    function getTimeslotCount() public view returns (uint256) {
        return timeslotCount;
    }

    function addTimeslot(
        string memory _duration,
        string memory _Price
    ) public {
        timeslots[timeslotCount] = Timeslot(
            timeslotCount,
            _duration,
            _Price
        );
        emit TimeslotAdded(timeslotCount);
        timeslotCount++;
    }

    function deleteTimeslot(uint256 _id) public {
        delete timeslots[_id];
        timeslotCount--;
        emit TimeslotDeleted(_id);
    }

    function editTimeslot(
        uint256 _id,
        string memory _duration,
        string memory _Price
    ) public {
        timeslots[_id] = Timeslot(_id, _duration, _Price);
        emit TimeslotEdited(_id);
    }
}

    

    