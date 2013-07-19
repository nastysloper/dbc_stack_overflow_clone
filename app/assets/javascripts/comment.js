var Handlers = {
  click: {
    a: {
      reply: function(e) {
        console.log('click a reply');
        e.preventDefault();
        $this = $(this)
        $this.next('div.reply').find('form').toggle('hidden');
        if ($this.text() == 'cancel') {
          $this.text('reply');
        } else {
          $this.text('cancel')
        }
      },
      
      upVote: function(e) {
        console.log('click a upVote');
        e.preventDefault();
        var commentId = $(this).parent().data('id')
        Helpers.post.vote(commentId, 1);
      },
      downVote: function(e) {
        console.log('click a downVote');
        e.preventDefault();
        var commentId = $(this).parent().data('id')
        Helpers.post.vote(commentId, -1);
      }
    }
  }
}
var Helpers = {
  post: {
    vote: function(commentId, value) {
      $.post('/votes', {"vote": {"comment_id": commentId, "value": value}})
    }
  }
}
var onReady = function onReady() {
  console.log('onReady');
  $('a.reply').on('click', Handlers.click.a.reply);
  $('a.up-vote').on('click', Handlers.click.a.upVote);
  $('a.down-vote').on('click', Handlers.click.a.downVote);
};

$(document).ready(onReady);