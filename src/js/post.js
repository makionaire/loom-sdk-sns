function setNewJob() {
    var _title = document.getElementById("title").value;
    var _price = document.getElementById("price").value;
    var _style = document.getElementById("style").value;
    var _desc = document.getElementById("description").value;
  
    contract.methods.newJob(_title,  _price, _style, _desc).send();
  }
  
  function setNewCommentToJob (){
    var _jobId = document.getElementById("jobId").jobId;
    var _text = document.getElementById("text").text;
  
    contract.methods.newCommentToJob(_jobId,  _text).send();
  }
  
  function setNewCommentToComment (){
    var _commentId = document.getElementById("commentId").commentId;
    var _text = document.getElementById("text").text;
  
    contract.methods.newCommentToComment(_commentId,  _text).send();
  }
  
  function setLikeToJob (){
    var _jobId = document.getElementById("jobId").jobId;
    contract.methods.likeToJob(_jobId).send();
  }
  
  function get(_num) {
      contract.methods.jobs(_num).call().then(function(_val){
          console.log(_val);
      });
  }