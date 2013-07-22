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
      $this.parent().siblings('.comment_text').toggle('hidden');
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
      console.log('vote submitUp');
      e.preventDefault();
      $.post(e.currentTarget.action, $(e.currentTarget).serialize(), Handlers.vote.response);
    },
    submitDown: function(e) {
      console.log('vote submitDown');
      e.preventDefault();
      $.post(e.currentTarget.action, $(e.currentTarget).serialize(), Handlers.vote.response);
    },
    clickDelete: function(e) {
      console.log('vote clickDelete');
      $.ajax(e.currentTarget.href, {"method": "DELETE", "success": Handlers.vote.response});
      return false;
    },
    response: function(data) {
      console.log('vote response');
      var commentId = $(data).data('comment-id');
      $('[data-comment-id="' + commentId + '"]').replaceWith(data);
      onReady();
    }
  }
}

var onReady = function onReady() {
  console.log('onReady');
  $('a.reply').off('click');
  $('a.reply').on('click', Handlers.reply.toggle);
  
  $('a.delete').off('click');
  $('a.delete').on('click', Handlers.delete.click);
  
  $('a.edit').off('click');
  $('a.edit').on('click', Handlers.edit.toggle);
  
  $('form.reply').off('submit');
  $('form.reply').on('submit', Handlers.reply.submit);
  
  $('form.edit').off('submit');
  $('form.edit').on('submit', Handlers.edit.submit);
  
  $('button.upvote').parent().off().on('submit');
  $('button.upvote').parent().on('submit', Handlers.vote.submitUp);
  
  $('button.downvote').parent().off().on('submit');
  $('button.downvote').parent().on('submit', Handlers.vote.submitDown);
  
  $('a.delete-vote').off('click');
  $('a.delete-vote').on('click', Handlers.vote.clickDelete);
};

$(document).ready(onReady);