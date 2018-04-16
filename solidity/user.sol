pragma solidity ^0.4.16;

contract UserContainer{
    address public owner;
    
    address[] private userList;
    uint index = 0;
    mapping(address => uint) userListIndex;
    
    event transferOwner(address oldOwner, address newOwenr);
    
    modifier onlyOwner(){if(msg.sender!=owner) throw;_;}
    
    
    function UserContainer(){
        owner = msg.sender;
    }
    
    function insertUser(address newUser) onlyOwner{
        userList.push(newUser);
        
    }
    
    function deleteUser(address deleteUser) onlyOwner{
        //userList[userListIndex[deleteUser]] = 0x00;
    }
    
    function getUserList() constant public returns (address[]){
        return userList;
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







contract UserPrivateInfo is Admin{
    
    mapping (address => PrivateInfo) private privateInfo;
    
    
    struct PrivateInfo{
        string certType;
        string certId;
        address[] voteRefuseCompanyAddr;
        address[] recruitingCompanyAddr;
    }

    function insertPrivateInfo(string _certType,
        string _certId,
        address[] _voteRefuseCompanyAddr,
        address[] _recruitingCompanyAddr){
            
            privateInfo[msg.sender].certType = _certType;
            privateInfo[msg.sender].certId =_certId;
            privateInfo[msg.sender].voteRefuseCompanyAddr =_voteRefuseCompanyAddr;
            privateInfo[msg.sender].recruitingCompanyAddr =_recruitingCompanyAddr;
    }
    function getPrivateInfo(address _addr) constant returns (string ,
        string ,
        address[] ,
        address[]){
        return (privateInfo[_addr].certType, privateInfo[_addr].certId, privateInfo[_addr].voteRefuseCompanyAddr, privateInfo[_addr].recruitingCompanyAddr);
    }
}








contract UserMainInfo is Admin{
    modifier CertAddress() {if(ownerAddr[msg.sender] != msg.sender) throw;_;}
    
    mapping (address => bool) private initWrite;
    mapping (address => address) private ownerAddr;
    mapping (address => string) private picture;
    mapping (address => string) private name;
    mapping (address => string) private job;
    mapping (address => string) private company;
    mapping (address => bytes32[]) private interestItem;
    mapping (address => uint256) private profileInfoAddr;
    mapping (address => uint256) private privateInfoAddr;
    mapping (address => uint8) private mvp;
    
    //check write time
    mapping (address => uint256) private updateTime;
    
    //when User First Assigned Service, call it
    function checkOwn(){
        if(initWrite[msg.sender] == false){
            ownerAddr[msg.sender] = msg.sender;
            initWrite[msg.sender] = true;
            mvp[msg.sender] = 50;
        }
    }
    
    function checkOwnAccount(address _addr) constant returns (address){
        return ownerAddr[_addr];
    }
    
    function insertMainInfo(string _picture, string _name, string _job, string _company, bytes32[] _interestItem) CertAddress{
            
            updateTime[msg.sender] = now;
            picture[msg.sender] = _picture;
            name[msg.sender] =_name;
            job[msg.sender] =_job;
            company[msg.sender] =_company;
            interestItem[msg.sender] =_interestItem;
    }
    
    
    function getBasicInfo(address _addr) constant returns (string , string, string, string, bytes32[] ,uint256, uint8){
        return (picture[_addr], name[_addr], job[_addr], company[_addr], interestItem[_addr], updateTime[_addr], mvp[_addr]);
    }
}






contract UserProfileInfo is Admin{
    mapping (address => address) private ownerAddr;
    
    mapping (address => bool) private initWrite;
    mapping (address => bytes32[]) private educationHistory;
    mapping (address => bytes32[]) private careerHistory;
    mapping (address => bytes32[]) private achievements;
    
    
    modifier CertAddress() {if(ownerAddr[msg.sender] != msg.sender) throw;_;}

    

    function UserProfileInfo(){
        owner=msg.sender;
    }
    
    function checkOwn(){
        if(initWrite[msg.sender] == false){
            ownerAddr[msg.sender] = msg.sender;
            initWrite[msg.sender] = true;
        }
    }
    
    function checkOwnAccount(address _addr) constant returns (address){
        return ownerAddr[_addr];
    }
    
    function insertProfileInfo(
        bytes32[] _educationHistory,
        bytes32[] _careerHistory,
        bytes32[] _achievements) CertAddress{
        
        educationHistory[msg.sender] = _educationHistory;
        careerHistory[msg.sender] =_careerHistory;
        achievements[msg.sender] =_achievements;

    }
    
    function getProfileInfo(address _addr) constant returns (bytes32[],bytes32[],bytes32[]){
        return (educationHistory[_addr], careerHistory[_addr], achievements[_addr]);
    }
}




contract UserFreeVision is Admin{
    mapping (address => address) private ownerAddr;
    mapping (address => bool) private initWrite;
    mapping (address => string) private freeVision;
    
    
    modifier CertAddress() {if(ownerAddr[msg.sender] != msg.sender) throw;_;}

    function UserFreeVision(){
        owner=msg.sender;
    }
    function checkOwn(){
        if(initWrite[msg.sender] == false){
            ownerAddr[msg.sender] = msg.sender;
            initWrite[msg.sender] = true;
        }
    }
    function checkOwnAccount(address _addr) constant returns (address){
        return ownerAddr[_addr];
    }
    
    function insertUserFreeVision(
        string _freeVision) CertAddress{
        
        freeVision[msg.sender] = _freeVision;
    }
    
    function getUserFreeVision(address _addr) constant returns (string){
        return freeVision[_addr];
    }
}




contract UserHideInfo is Admin{
    
    mapping (address => address) private ownerAddr;
    mapping (address => bool) private initWrite;
    mapping (address => uint) private value;
    mapping (address => int8) private estimateValue;
    mapping (address => uint) private openCount;
    mapping (address => bytes32[]) private hint;
    
    
    modifier CertAddress() {if(ownerAddr[msg.sender] != msg.sender) throw;_;}
    modifier ExceptMyAddress() {if(ownerAddr[msg.sender] == msg.sender) throw;_;}
    
    function UserHideInfo(){
        owner=msg.sender;
    }
    function checkOwn(){
        if(initWrite[msg.sender] == false){
            ownerAddr[msg.sender] = msg.sender;
            initWrite[msg.sender] = true;
            openCount[msg.sender] = 0;
        }
    }
    function checkOwnAccount(address _addr) constant returns (address) {
        return ownerAddr[_addr];
    }
    
    function insertUserHideInfo (uint _value, bytes32[] _hint) CertAddress{
        
        value[msg.sender] = _value;
        hint[msg.sender] = _hint;
    }
    
    function updateEstimateValue(address _addr, int8 updatePm) ExceptMyAddress{
        estimateValue[_addr] +=updatePm;
    }
    
    function openCountUpdata(address _addr) private ExceptMyAddress{
        openCount[_addr] +=1;
    }
    
    
    function getUserHideInfo(address _addr) constant returns (uint,int,uint,bytes32[]){
        return (value[_addr],estimateValue[_addr], openCount[_addr],hint[_addr]);
    }
}