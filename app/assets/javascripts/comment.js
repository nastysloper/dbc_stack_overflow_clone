var Handlers = {
  submit: {
    reply: function(e) {
      console.log('submit reply');
      e.preventDefault();
      parentId = $(this).parent().data('id')
      $.post(e.currentTarget.action, $(this).serialize(), Handlers.response.reply);
    },
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
    },
    reply: function(data) {
      console.log('response reply');
      var parentId = $(data).data('id');
      $('div.comments[data-id="' + parentId + '"]').replaceWith(data);
      onReady();
    },
    delete: function(data) {
      console.log('response delete');
      $('div.comments[data-id="' + data + '"]').remove();
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
      },
      edit: function(e) {
        console.log('click a edit');
        e.preventDefault();
        $this = $(this)
        $this.siblings('div.text').toggle('hidden');
        $this.siblings('form.edit').toggle('hidden');
        if ($this.text() == 'cancel') {
          $this.text('edit');
        } else {
          $this.text('cancel')
        }
      },
      delete: function(e) {
        console.log('click a delete');
        $.ajax(e.currentTarget.href, {"method": "DELETE", "success": Handlers.response.delete});
        return false;
      }
    }
  }
}

var onReady = function onReady() {
  console.log('onReady');
  $('a.reply').on('click', Handlers.click.a.reply);
  $('a.delete').on('click', Handlers.click.a.delete);
  $('a.edit').on('click', Handlers.click.a.edit);
  $('form.reply').on('submit', Handlers.submit.reply);
  $('button.upvote').parent().on('submit', Handlers.submit.upVote);
  $('button.downvote').parent().on('submit', Handlers.submit.downVote);
  $('button.unvote').parent().on('submit', Handlers.submit.unVote);
};

$(document).ready(onReady);