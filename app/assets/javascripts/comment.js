var Handlers = {
  submit: {
    upVote: function(e) {
      console.log('submit upVote');
      e.preventDefault();
      $.post(e.currentTarget.action, $(e.currentTarget).serialize(), Handlers.response.changeVote);
    },
    downVote: function(e) {
      console.log('submit downVote');
      e.preventDefault();
      $.post(e.currentTarget.action, $(e.currentTarget).serialize(), Handlers.response.changeVote);
    },
    unVote: function(e) {
      console.log('submit unVote');
      e.preventDefault();
      $.ajax(e.currentTarget.action, {"method": "DELETE", "success": Handlers.response.changeVote});
    }
  },
  response: {
    changeVote: function(data) {
      console.log('response changeVote');
      $data = $(data);
      var commentId = $data.find('input#vote_comment_id').attr('value');
      $('div.comments[data-id="' + commentId + '"]').find('div.votes-forms').first().html(data);
      onReady();
    }
  },
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
    }
  }
}

var onReady = function onReady() {
  console.log('onReady');
  $('a.reply').on('click', Handlers.click.a.reply);
  $('button.upvote').parent().on('submit', Handlers.submit.upVote);
  $('button.downvote').parent().on('submit', Handlers.submit.downVote);
  $('button.unvote').parent().on('submit', Handlers.submit.unVote);
};

$(document).ready(onReady);