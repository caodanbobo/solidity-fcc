// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

//0x137815daae130e3a66a7296dd6941247cf5cb153
contract SimpleStorage {

    //the default visibility is internal
    //visibililty public would create a getter automatically
    uint256 favoriteNumber=5;
    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    function store(uint256 _favoriteNumber) public virtual  {
        favoriteNumber=_favoriteNumber;
        //doing extra staff would lead to the increasing of the transaction cost,
        //favoriteNumber=_favoriteNumber+1;  //26916
        // and using the state would be more expansive
        //favoriteNumber=favoriteNumber+1; //27015
        
        
    }
    //view: read state only
    function retrieve() public view returns(uint256 ){
        return favoriteNumber;
    }

    function addPerson(string memory _name , uint256 _number) public {
        //midifying is not allow if _name is marked as "calldata"
        //_name = "tom";
        //People memory newP=People(_number, _name);
        people.push(People(_number, _name));
        nameToFavoriteNumber[_name]=_number;
    }
}