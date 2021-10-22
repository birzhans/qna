module ApplicationHelper

  def vote_class(votable_id, user_id, kind)
    return if user_id.nil?

    if Vote.find_by(votable_id: votable_id, user_id: user_id, kind: kind)
      'active'
    end
  end
end
