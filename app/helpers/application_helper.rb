module ApplicationHelper
  def vote_class(votable, user_id, kind)
    return if user_id.nil?

    'active' if Vote.find_by(votable: votable, user_id: user_id, kind: kind)
  end
end
