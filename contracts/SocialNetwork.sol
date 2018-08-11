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
    
    struct Profile {
        string name;
    }
    
    
    mapping (address => uint[]) public jobsFromAccount;
    mapping (uint => uint[]) public commentsFromJob;
    mapping (uint => uint[]) public commentsFromComment;
    mapping (uint => address) public commentFromAccount; 
    mapping (uint => address[]) public likesFromAccount;
    mapping (address => uint[]) public addressToLike;
    mapping (address => uint) public profileMap;

    Job[] public jobs;
    Comment[] public comments;
    Profile[] public profile;

    event NewPostAdded(uint jobId, uint commentId, address owner);
    event NewCommentAdded(uint toCommentId, uint commentId, address owner);
    event NewLike(uint jobId, address owner);

    constructor () public {
        // created the first post and comment with ID
        // IDs 0 are invalid
        newJob("",0,0,"");
        newCommentToJob(0, "");
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
        require(addressToLike[msg.sender][_jobId] == 0);
        likesFromAccount[_jobId].push(msg.sender);
        jobs[_jobId].likeCount = jobs[_jobId].likeCount + 1;
        addressToLike[msg.sender][_jobId] = 1;
        emit NewLike(_jobId, msg.sender);
    }
}
