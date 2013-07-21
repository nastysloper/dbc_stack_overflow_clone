var Handlers = {
  reply: {
    toggle: function(e) {
      console.log('reply toggle');
      e.preventDefault();
      $this = $(this)
      $this.next('form').toggle('hidden');
      if ($this.text() == 'cancel') {
        $this.text('reply');
      } else {
        $this.text('cancel')
      }
    },
    submit: function(e) {
      console.log('reply submit');
      e.preventDefault();
      $.post(e.currentTarget.action, $(this).serialize(), Handlers.reply.response);
    },
    response: function(data) {
      console.log('reply respone');
      var parentId = $(data).data('id');
      $('div.comments[data-id="' + parentId + '"]').replaceWith(data);
      onReady();
    }
  },
  edit: {
    toggle: function(e) {
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
    submit: function(e) {
      console.log('submit edit');
      e.preventDefault();
      $.post(e.currentTarget.action, $(this).serialize(), Handlers.edit.response);
    },
    response: function(data) {
      console.log('response reply');
      var commentId = $(data).find('input#vote_comment_id').attr('value');
      $('div.comments[data-id="' + commentId + '"]').replaceWith(data);
      onReady();
    }
  },
  delete: {
    click: function(e) {
      console.log('delete click');
      $.ajax(e.currentTarget.href, {"method": "DELETE", "success": Handlers.delete.response});
      return false;
    },
    response: function(data) {
      console.log('response delete');
      $('div.comments[data-id="' + data + '"]').remove();
    }
  },
  vote: {
    submitUp: function(e) {
      console.log('submit upVote');
      e.preventDefault();
      $.post(e.currentTarget.action, $(e.currentTarget).serialize(), Handlers.vote.response);
    },
    submitDown: function(e) {
      console.log('submit downVote');
      e.preventDefault();
      $.post(e.currentTarget.action, $(e.currentTarget).serialize(), Handlers.vote.response);
    },
    submitDelete: function(e) {
      console.log('submit unVote');
      e.preventDefault();
      $.ajax(e.currentTarget.action, {"method": "DELETE", "success": Handlers.vote.response});
    },
    response: function(data) {
      console.log('response changeVote');
      $data = $(data);
      var commentId = $data.find('input#vote_comment_id').attr('value');
      $('div.comments[data-id="' + commentId + '"]').find('div.votes-forms').first().html(data);
      onReady();
    }
  }
}

var onReady = function onReady() {
  console.log('onReady');
  $('a.reply').on('click', Handlers.reply.toggle);
  $('a.delete').on('click', Handlers.delete.click);
  $('a.edit').on('click', Handlers.edit.toggle);
  $('form.reply').on('submit', Handlers.reply.submit);
  $('form.edit').on('submit', Handlers.edit.submit);
  $('button.upvote').parent().on('submit', Handlers.vote.submitUp);
  $('button.downvote').parent().on('submit', Handlers.vote.submitDown);
  $('button.unvote').parent().on('submit', Handlers.vote.submitDelete);
};

$(document).ready(onReady);