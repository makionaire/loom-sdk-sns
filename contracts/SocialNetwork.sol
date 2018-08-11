pragma solidity ^0.4.24;

contract SimpleSocialNetwork {

    struct Job {
        string title;
        uint price;
        uint style;
        string desc;
        uint likeCount;
        
    }

    struct Comment {
        string text;
        uint likeCount;
    }
    

    string public name = 'Trust workers';
    string public symbol = 'TTW';
    uint public decimals = 18;
    uint public totalSupply;
    
    uint private initialSupply = 1000;
    
    mapping(address => uint) public balances;
    mapping(address => mapping (address => uint)) internal allowed;

    
    mapping (address => uint[]) public jobsFromAccount;
    mapping (uint => address) public jobToAddress;
    mapping (uint => uint[]) public commentsFromJob;
    mapping (uint => uint[]) public commentsFromComment;
    mapping (uint => address) public commentFromAccount; 
    mapping (uint => address[]) public likesFromAccount;
    mapping (address => mapping (uint => bool)) public addressToLike;
    mapping (address => uint) public profileMap;
    mapping (uint => address) public profileToAddress;
    mapping (uint => address[]) public follows;
    mapping (uint => address[]) public followers;
    mapping (address => mapping (uint => bool)) public addressToFollow;
    
    struct Profile {
        uint id;
        string name;
        string overview;
    }
    

    Job[] public jobs;
    Comment[] public comments;
    Profile[] public profile;

    event NewPostAdded(uint jobId, uint commentId, address owner);
    event NewCommentAdded(uint toCommentId, uint commentId, address owner);
    event NewLike(uint jobId, address owner);
    event NewProfile(uint profileId, address owner);
    event NewFollow(uint profileId, address owner);
    
    event Transfer(address indexed from, address indexed to, uint value);


    constructor () public {
        // created the first post and comment with ID
        // IDs 0 are invalid
        newJob("",0,0,"");
        newCommentToJob(0, "");
        createProfile("","");
        
        uint _initialSupply = 10000;

        balances[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;

    }

    function hasJobs() public view returns(bool _hasJobs) {
        _hasJobs = jobs.length > 0;
    }


    function newJob(
        string _title,
        uint _price,
        uint _style,
        string _desc
    ) public {
        Job memory job = Job(_title, _price, _style, _desc, 0);
        uint jobId = jobs.push(job) -1 ;
        jobsFromAccount[msg.sender].push(jobId);
        jobToAddress[jobId] = msg.sender;
        emit NewPostAdded(jobId, 0, msg.sender);
    }

    function newCommentToJob(uint _jobId, string _text) public {
        Comment memory comment = Comment(_text, 0);
        uint commentId = comments.push(comment) - 1;
        commentsFromJob[_jobId].push(commentId);
        commentFromAccount[commentId] = msg.sender;
        emit NewPostAdded(_jobId, commentId, msg.sender);
    }

    function newCommentToComment(uint _commentId, string _text) public {
        Comment memory comment = Comment(_text, 0);
        uint commentId = comments.push(comment) - 1;
        commentsFromComment[_commentId].push(commentId);
        commentFromAccount[commentId] = msg.sender;
        emit NewCommentAdded(_commentId, commentId, msg.sender);
    }

    function likeToJob(uint _jobId) public {
        require (!addressToLike[msg.sender][_jobId]);
        require(1 <= balances[msg.sender]);
        likesFromAccount[_jobId].push(msg.sender);
        jobs[_jobId].likeCount = jobs[_jobId].likeCount + 1;
        addressToLike[msg.sender][_jobId] = true;
        balances[msg.sender] -= 1;
        balances[jobToAddress[_jobId]] += 1;
        emit Transfer(msg.sender, jobToAddress[_jobId], 1);
        emit NewLike(_jobId, msg.sender);
    }
    
    function createProfile(string _name, string _overview) public {
        require (profileMap[msg.sender] == 0);
        uint profileId = profile.length;
        Profile memory newProfile = Profile(profileId, _name, _overview);
        profile.push(newProfile);
        profileMap[msg.sender] = profileId;
        profileToAddress[profileId] = msg.sender;
        balances[msg.sender] = initialSupply;
        totalSupply = totalSupply + initialSupply;
        
        emit NewProfile(profileId, msg.sender);
    }
    
    function follow (uint _profileId) public {
        require (!addressToFollow[msg.sender][_profileId]);
        require (profileToAddress[_profileId] != msg.sender);
        followers[_profileId].push(msg.sender);
        Profile memory myProfile = profile[profileMap[msg.sender]];
        follows[myProfile.id].push(profileToAddress[_profileId]);
        addressToFollow[msg.sender][_profileId] = true;
        emit NewFollow(_profileId, msg.sender);
    }
    
    
    function totalSupply() public view returns (uint) {
        return (totalSupply);
    }
    
    function balanceOf(address _owner) public view returns (uint) {
        return (balances[_owner]);
    }
    
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_value <= balances[msg.sender]);

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns (bool) {
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);

        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) public view returns (uint) {
        return allowed[_owner][_spender];
    }

    event Approval(address indexed owner, address indexed spender, uint value);
     
     

}
