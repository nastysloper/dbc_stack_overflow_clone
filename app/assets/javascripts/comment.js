var Handlers = {
  click: {
    a: {
      reply: function(e) {
        console.log('click a reply');
        e.preventDefault();
        $this = $(this)
        $this.next('form').toggle('hidden');
        if ($this.text() == 'cancel') {
          $this.text('reply');
        } else {
          $this.text('cancel')
        }
      }
      // ,
      // upVote: function(e) {
      //   console.log('click a upVote');
      //   e.preventDefault();
      //   var commentId = $(this).parent().data('id');
      //   Helpers.post.vote(commentId, 1);
      // },
      // downVote: function(e) {
      //   console.log('click a downVote');
      //   e.preventDefault();
      //   var commentId = $(this).parent().data('id');
      //   Helpers.post.vote(commentId, -1);
      // },
      // unVote: function(e) {
      //   console.log('click a unVote');
      //   e.preventDefault();
      //   var id = $(this).data('id');
      //   Helpers.delete.vote(id);
      // }
    }
  }
}

var Helpers = {
  post: {
    vote: function(commentId, value) {
      $.post('/votes', {"vote": {"comment_id": commentId, "value": value}})
    }
  }
  // ,
  // delete: {
  //   vote: function(id) {
  //     $.ajax('/votes/' + id, {"type": "DELETE"});
  //   }
  // }
}
var onReady = function onReady() {
  console.log('onReady');
  $('a.reply').on('click', Handlers.click.a.reply);
  // $('a.up-vote').on('click', Handlers.click.a.upVote);
  // $('a.down-vote').on('click', Handlers.click.a.downVote);
  // $('a.un-vote').on('click', Handlers.click.a.unVote);
};

$(document).ready(onReady);