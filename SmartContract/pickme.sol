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
    mapping (address => uint256) private token;
    mapping (address => uint256) private hideInfoAddr;
    mapping (address => uint256) private profileInfoAddr;
    mapping (address => ProfileInfo) private profileInfo;
    mapping (address => uint256) private initWriteTime;
    mapping (address => bool) private initWriteYn;
    
    struct ProfileInfo{
        string myProfilePictureUrl;
        string job;
        uint _mvp;
        bool scouterYn;
        string nowCompany;
        string freeIntroduce;
    }


    function UserProfileInfo(){
        owner=msg.sender;
    }

    function insertProfileInfo(
        string _myProfilePictureUrl,
        string _job,
        bool _scouterYn,
        string _nowCompany,
        string _freeIntroduce){
        
        if(initWriteYn[msg.sender] ==false){
            initWriteTime[msg.sender] = now;
            initWriteYn[msg.sender] = true;
        }
        
        profileInfo[msg.sender].myProfilePictureUrl =_myProfilePictureUrl;
        profileInfo[msg.sender].job =_job;
        profileInfo[msg.sender].scouterYn =_scouterYn;
        profileInfo[msg.sender].nowCompany =_nowCompany;
        profileInfo[msg.sender].freeIntroduce =_freeIntroduce;
    }
    
    
    
    function getProfileInfo(address _addr) constant returns (string ,
        string ,
        bool ,
        string ,
        string){
        return (profileInfo[_addr].myProfilePictureUrl,profileInfo[_addr].job ,profileInfo[_addr].scouterYn ,profileInfo[_addr].nowCompany,profileInfo[_addr].freeIntroduce);
    }
}