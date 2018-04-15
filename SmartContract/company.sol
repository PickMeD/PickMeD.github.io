pragma solidity ^0.4.16;

contract CompanyContainer{
    address public owner;
    
    address[] private companyList;
    
    uint index = 0;
    mapping(address => uint) companyListIndex;
    
    event transferOwner(address oldOwner, address newOwenr);
    
    modifier onlyOwner(){if(msg.sender!=owner) throw;_;}
    
    
    function CompanyContainer(){
        owner = msg.sender;
    }
    
    function insertCompany(address newUser) onlyOwner{
        companyList.push(newUser);
    }
    
    function deleteCompany(address deleteUser) onlyOwner{
        //userList[userListIndex[deleteUser]] = 0x00;
    }
    
    function getCompanyList() constant public returns (address[]){
        return companyList;
    }
}


contract Admin{
    
    address public owner;
    
    event TransferOwnership(address  _addr, address newAddr);
    
    modifier onlyOwner() {if(msg.sender!=owner) throw;_;}

    
    //Generater
    function Admin(){
        owner = msg.sender;
    }
    
    function transferOwnership(address newOwenr) onlyOwner{
        address oldOwner = owner;
        owner = newOwenr;
        TransferOwnership(oldOwner, newOwenr);
    }
}



contract CompanyMainInfo is Admin{
    mapping (address => string) private picture;
    mapping (address => string) private name;
    mapping (address => string) private category;
    mapping (address => uint256) private updateTime;
    
    function insertCompanyMainInfo(address _addr, string _picture, string _name, string _category ) onlyOwner{
            
            updateTime[_addr] = now;
            picture[_addr] = _picture;
            name[_addr] =_name;
            category[_addr] = _category;
    }
    
    function getCompanyMainInfo(address _addr) constant returns (string, string, string, uint256){
        return (picture[_addr], name[_addr],  category[_addr], updateTime[_addr]);
    }
}


