function setNewJob() {
  var _title = document.getElementById("title").title;
  var _price = document.getElementById("price").price;
  var _style = document.getElementById("style").style;
  var _desc = document.getElementById("description").desc;

  contract.methods.newJob(_title,  _price, _style, _desc).send();
  contract.methods.job(1).call().then(function(_val){
      console.log(_val);
  });
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

function get() {
    contract.methods.job(1).call().then(function(_val){
        console.log(_val);
    });
}
