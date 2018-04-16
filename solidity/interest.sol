pragma solidity ^0.4.16;


contract InterestContainer {
    
    address public owner;
    
    bytes24[] private InterestItemList;
    
    mapping(bytes24 => uint) interstInYn;
    mapping(bytes24 => address) interstAddr;
    
    
    event transferOwner(address oldOwner, address newOwenr);
    modifier onlyOwner(){if(msg.sender!=owner) throw;_;}
    
    function InterestContainer(){
        owner = msg.sender;
    }
    
    function insertInterestItem(bytes24 keyWord, address _Addr) onlyOwner{
        InterestItemList.push(keyWord);
        interstInYn[keyWord] = 1;
        interstAddr[keyWord] = _Addr;
    }
    
    function getInterestInYn(bytes24 keyWord) constant public returns (bool){
        if(interstInYn[keyWord] == 0) return false;
        
        return true;
    }
    function getInterestAddr(bytes24 keyWord) constant public returns (address){
        return interstAddr[keyWord];
    }
    
    
    function getInterestItemList() constant public returns (bytes24[]){
        return InterestItemList;
    }
    
}


contract InterstObject {
    address public owner;
    modifier onlyOwner(){if(msg.sender!=owner) throw;_;}
    string name;
    
    address [] userList;
    address [] companyList;
    
    function InterstObject(string _name){
        owner = msg.sender;
        name = _name;
    }
    
    function getName() constant returns (string){
        return name;
    }
    function insertInterestObject(string _name, address _addr, uint dir) onlyOwner{
        name = _name;
        if(dir == 0){
            userList.push(_addr);
        }else{
            companyList.push(_addr);
        }
    }
}