module ApplicationHelper
  NOTICE_KEYS = {
    alert: "alert alert-danger", notice: "alert alert-info", success: "alert alert-success",
    warning: "alert alert-warning", primary: "alert alert-primary"
  }

  def vote_class(votable, user, kind)
    'active' if votable.voted_with_kind?(user, kind)
  end

  def message_class(key)
    NOTICE_KEYS[key.to_sym]
  end
end
